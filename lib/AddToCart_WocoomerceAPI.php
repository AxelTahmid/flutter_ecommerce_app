<?php
includes/rest-api/Controllers/Version3/class-wc-rest-webhooks-controller.php

/** woocommerce\packages\woocommerce-rest-api\src\Controllers\version3\class-wc-rest-webhooks-controller.php */
/**
 * REST API Webhooks controller
 *
 * Handles requests to the /webhooks endpoint.
 *
 * @package Automattic/WooCommerce/RestApi
 * @since   2.6.0
 */

defined('ABSPATH') || exit;

/**
 * REST API Webhooks controller class.
 *
 * @package Automattic/WooCommerce/RestApi
 * @extends WC_REST_Webhooks_V2_Controller
 */
class WC_REST_Webhooks_Controller extends WC_REST_Webhooks_V2_Controller
{

    /**
     * Endpoint namespace.
     *
     * @var string
     */
    protected $namespace = 'wc/v3';

    /**
     * Get the default REST API version.
     *
     * @since  3.0.0
     * @return string
     */
    protected function get_default_api_version()
    {
        return 'wp_api_v3';
    }

    protected $rest_base = 'custom';

    function woocomm_add_to_cart($param)
    {

        global $wpdb;
        $user_id = $param['user_id'];
        wp_set_current_user($user_id);

        $objProduct = new WC_Session_Handler();
        $wc_session_data = $objProduct->get_session($user_id);

        // Get the persistent cart may be _woocommerce_persistent_cart can be in your case check in user_meta table
        $full_user_meta = get_user_meta($user_id, '_woocommerce_persistent_cart_1', true);

        if (defined('WC_ABSPATH')) {
            // WC 3.6+ - Cart and other frontend functions are not included for REST requests.
            include_once WC_ABSPATH . 'includes/wc-cart-functions.php';
            include_once WC_ABSPATH . 'includes/wc-notice-functions.php';
            include_once WC_ABSPATH . 'includes/wc-template-hooks.php';
        }

        if (null === WC()->session) {
            $session_class = apply_filters('woocommerce_session_handler', 'WC_Session_Handler');

            WC()->session = new $session_class();
            WC()->session->init();
        }

        if (null === WC()->customer) {
            WC()->customer = new WC_Customer(get_current_user_id(), true);
        }

        if (null === WC()->cart) {
            WC()->cart = new WC_Cart();

            // We need to force a refresh of the cart contents from session here (cart contents are normally refreshed on wp_loaded, which has already happened by this point).
            WC()->cart->get_cart();
        }

        // create new Cart Object
        $cartObj = WC()->cart;


        // Add old cart data to newly created cart object
        if ($full_user_meta['cart']) {
            foreach ($full_user_meta['cart'] as $sinle_user_meta) {
                $cartObj->add_to_cart($sinle_user_meta['product_id'], $sinle_user_meta['quantity'], $sinle_user_meta['variation_id']);
            }
        }

        // Add product and quantities coming in request to the new cart object
        if ($param['products']) {
            WC()->cart->empty_cart();
            foreach ($param['products'] as $prod) {
                $cartObj->add_to_cart($prod['product_id'], $prod['quantity'], $prod['variation_id']);
            }
        }

        $updatedCart = [];
        foreach ($cartObj->cart_contents as $key => $val) {
            unset($val['data']);
            $updatedCart[$key] = $val;
        }

        // If there is a current session cart, overwrite it with the new cart
        if ($wc_session_data) {
            $wc_session_data['cart'] = serialize($updatedCart);
            $serializedObj = maybe_serialize($wc_session_data);


            $table_name = 'wp_woocommerce_sessions';

            // Update the wp_session table with updated cart data
            $sql = "UPDATE $table_name SET session_value= '" . $serializedObj . "' WHERE  session_key = '" . $user_id . "'";

            // Execute the query
            $rez = $wpdb->query($sql);
        }


        // Overwrite the persistent cart with the new cart data
        $full_user_meta['cart'] = $updatedCart;


        $productsInCart = [];
        foreach ($cartObj->cart_contents as $cart_item) {
            $product =  $cart_item['variation_id'] == 0 ? wc_get_product($cart_item['product_id']) : wc_get_product($cart_item['variation_id']);
            $image_id  = $product->get_image_id();
            $image_url = wp_get_attachment_image_url($image_id, 'full');
            $attributes =  $product->get_attributes();

            $productsInCart[] = (object) [
                "product_id" => $cart_item['product_id'],
                "product_name" => wc_get_product($cart_item['product_id'])->get_name(),
                "product_regular_price" => $product->get_regular_price(),
                "product_sale_price" => $product->get_sale_price(),
                "thumbnail" => $image_url,
                "qty" => $cart_item['quantity'],
                "attribute" => $attributes,
                "line_subtotal" => $cart_item['line_subtotal'],
                "line_total" => $cart_item['line_total'],
                "variation_id" => $cart_item['variation_id'],
            ];
        }


        update_user_meta(get_current_user_id(), '_woocommerce_persistent_cart_1', array('cart' => $updatedCart,));

        $response = [
            'status' => true,
            'data' =>  $full_user_meta['cart'] != null ?  $productsInCart : []
        ];

        return rest_ensure_response($response);
    }

    function woocomm_cart_list($param)
    {
        $user_id = $param['user_id'];
        $objProduct = new WC_Session_Handler();

        $wc_session_data = $objProduct->get_session($user_id);

        // Get the persistent cart may be _woocommerce_persistent_cart can be in your case check in user_meta table
        $full_user_meta = get_user_meta($user_id, '_woocommerce_persistent_cart_1', true);

        $productsInCart = [];
        foreach ($full_user_meta['cart'] as $cart_item) {
            $product =  $cart_item['variation_id'] == 0 ? wc_get_product($cart_item['product_id']) : wc_get_product($cart_item['variation_id']);
            $image_id  = $product->get_image_id();
            $image_url = wp_get_attachment_image_url($image_id, 'full');
            $attributes =  $product->get_attributes();

            $productsInCart[] = (object) [
                "product_id" => $cart_item['product_id'],
                "product_name" => wc_get_product($cart_item['product_id'])->get_name(),
                "product_regular_price" => $product->get_regular_price(),
                "product_sale_price" => $product->get_sale_price(),
                "thumbnail" => $image_url,
                "qty" => $cart_item['quantity'],
                "attribute" => $attributes,
                "line_subtotal" => $cart_item['line_subtotal'] ?? 0,
                "line_total" => $cart_item['line_total'] ?? 0,
                "variation_id" => $cart_item['variation_id'],
            ];
        }

        $response = [
            'status' => true,
            'data' =>  $full_user_meta['cart'] != null ?  $productsInCart : []
        ];

        return rest_ensure_response($response);
    }

    public function register_routes()
    {
        register_rest_route(
            $this->namespace,
            '/addtocart',
            array(
                'methods' => 'POST',
                'callback' => array($this, 'woocomm_add_to_cart'),
            )
        );

        register_rest_route(
            $this->namespace,
            '/cart',
            array(
                'methods' => 'GET',
                'callback' => array($this, 'woocomm_cart_list'),
            )
        );
    }
}
