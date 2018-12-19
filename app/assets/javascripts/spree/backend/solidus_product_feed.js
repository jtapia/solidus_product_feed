Spree.ready(function() {
  'use strict';

  var itemIds = $('#product_catalog_item_ids');

  var selectUnselectAll = function(selected) {
    $('.item_ids').map(function(i, item) {
      $(item).prop('checked', selected);
    })
  };

  var selectedItems = function() {
    var catalog = [];
    var items = $('#product_catalog:checked');

    items.map(function(i, item) {
      catalog.push(item.value.toString());
    })

    return catalog;
  };

  var allChecked = function() {
    return $('.item_ids:checked').length === $('.item_ids').length;
  }

  $('#product-list-select-all').on('click', function(e) {
    e.preventDefault()

    if (allChecked() === true) {
      selectUnselectAll(false);
    } else {
      selectUnselectAll(true);
    }
  });
});
