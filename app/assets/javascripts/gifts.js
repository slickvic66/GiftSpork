var GI = function(){

  function initialize(){
    // Add click handlers to giftitem-remove a tags already on page
    addGiftIdeaRemoveHandler($('.giftidea-remove'))    
  }

  function addGiftIdeaRemoveHandler($element){
    $element.click(function(){
      var clicked = $(this).parent();
      var giftId = clicked.attr('data-giftidea-id');
      $.ajax({
        url:'/gift_ideas/'+giftId,
        type: 'post',
        data:{'_method':'delete'},
        success: function(response){
          console.log('success');
          removeFromShopping($(clicked));
        }
      })
    });
  }

  // Removes item from giftidea from giftlist
  function removeFromShopping($item){
    $item.fadeOut(function(){
      $item.remove().end();
    })
  };

  // Removes an item from a masonry container, adds it to shopping sidebar, and then reloads the masonry so a previously hidden item can bubble up from below

  function addToShopping($masonTbl, $item, giftIdeaId){
    var $giftlist = $('.shopping-sidebar ul');
    var $itemToAdd = $('<li>', 
                      { class:'clearfix',
                        html: 
                          '<img src='
                          + $item.attr('data-image')
                          + '>'
                          + $item.attr('data-name')
                          +'<br>'
                          + $item.attr('data-price')
                          + '<a class=\'giftidea-remove\'><i class=\'icon-remove-circle\'></i></a>'
                    }).attr('data-giftidea-id', giftIdeaId);

    $giftlist.append($itemToAdd);

    // The handler can only be added to the list elements a tag
    var $newRemoveTag= $itemToAdd.children('.giftidea-remove');
    GI.addRemoveHandler($newRemoveTag);

    $masonTbl.masonry('remove', $item).masonry('reload');
  };

  function ajaxAddGiftIdea(draggable, userId, exchangeId, $container){
      return $.post('/gift_ideas.json',
            // json object to post 
             {
                giftidea: {
                  user_id: userId,
                  exchange_id: exchangeId,
                  gift_id: draggable.attr('data-giftid'),
                  url: draggable.attr('data-gifturl'),
                  name: draggable.attr('data-name'),
                  price: draggable.attr('data-draggableprice'),
                  picture_url: draggable.attr('data-image')
                }
              },
            // Success callback
              function(response){
                console.log("Success");
                addToShopping($container, draggable, response);
              }
              );
  }


  return {
    start: initialize,
    addRemoveHandler: addGiftIdeaRemoveHandler,
    postGiftIdea: ajaxAddGiftIdea
  };
}();