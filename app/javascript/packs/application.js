// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


import 'packs/css/style.pink.css'
import 'packs/css/custom.css'


//require('smooth-scroll')
import '@popperjs/core'
import 'jquery'
import 'jquery.cookie'

import 'chart.js'
import 'dropzone'
import 'leaflet'
//import 'magnific-popup'
//import 'nouislider'
import 'object-fit-images'
import 'prismjs'
import 'smooth-scroll'
import 'swiper'

//import './datepicker-category'
//import './datepicker-detail'
//import './demo'
import './forms-dropzone'
import './map-category'
import './map-detail'
import './map-layers'
import './jquery.jpostal.js'
import './theme'
import "../js/hoge.js"

//import 'bootstrap'
require("object-fit-images")
require("magnific-popup")
require("nouislider")
require("bootstrap")
//require("bootstrap-select")

require("profile_image_upload");

require.context("../images", true)

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(function() {
    $(document).on('turbolinks:load', () => {
      $('#user_postal_code').jpostal({
        postcode : [
          '#user_postal_code'
        ],
        address: {
          "#user_prefecture_code": "%3", // # 都道府県が入力される
          "#user_city"           : "%4%5", // # 市区町村と町域が入力される
          "#user_street"         : "%6%7" // # 大口事務所の番地と名称が入力される
        }
      });
    });
  });

