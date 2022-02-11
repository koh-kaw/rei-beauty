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
require("jquery-ui/ui/widgets/datepicker");

// カード
//require("./card")
import './card'
import './test'

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
require("src/user_postal")

//require("profile_image_upload");

require.context("../images", true)


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)


// 住所自動入力
$(function() {
    $(document).on('turbolinks:load', () => {
      $('#business_user_postal_code').jpostal({
        postcode : [
          '#business_user_postal_code'
        ],
        address: {
          "#business_user_prefecture_code": "%3", // # 都道府県が入力される
          "#business_user_city"           : "%4%5", // # 市区町村と町域が入力される
          "#business_user_street"         : "%6%7" // # 大口事務所の番地と名称が入力される
        }
      });
    });
  });


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

// 画像アップロードプレビュー
$(function(){
  $fileField = $('#file')

  // 選択された画像を取得し表示
  $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img_field");

    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "100%",
          class: "preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});


