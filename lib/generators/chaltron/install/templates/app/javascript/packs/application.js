// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

// javascript
import '@fortawesome/fontawesome-free/js/all';
import 'datatables.net-bs4/js/dataTables.bootstrap4.js';

import './chaltron_datatables.js';
import './bootstrap_custom.js';
import './datatables.js';
import './home.js';

// stylesheets
import '@fortawesome/fontawesome-free/css/all';
import 'datatables.net-bs4/css/dataTables.bootstrap4.css';

import '../stylesheets/application';

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true);
const imagePath = (name) => images(name, true);
