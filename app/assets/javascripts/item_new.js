$(function(){
  // カテゴリーのセレクトボックスのオプション（セレクトボックス内に表示させる候補）
  function appendOption(category){
    var html = `<option data-category="${category.id}" value= "${category.id}">${category.name}</option>`;
    return html;
  }

  //子カテゴリーの表示を作成
  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `
    <select prompt="---" id="child_category" name="item[category_id]">
    <option value="---">---</option>
    ${insertHTML}
    </div>`
    

    $('#parent').append(childSelectHtml);
  }

  // //孫カテゴリーの表示作成
  // function appendGrandchidrenBox(insertHTML){
  //   var grandchildSelectHtml = ``
  //   $('.listing-product-detail__category').append(grandchildSelectHtml);
  // }

  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value;
    
    if (parentCategory != "---"){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })

      .done(function(children){
        console.log(children)
        // 上記のchildrenの定義が不明
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        // $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
          // console.log("child.name")
          console.log("child.ancestry")
        });
        console.log(insertHTML)
        // ↑子カテゴリーの名前が入ったhtmlを返す
        appendChildrenBox(insertHTML);
      })
  
      .fail(function(){
        console.log("fail")
        alert('カテゴリー取得に失敗しました');
      })

    }else{
      $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchildren_wrapper').remove();
      // $('#brand_wrapper').remove();
    }
  });
});

