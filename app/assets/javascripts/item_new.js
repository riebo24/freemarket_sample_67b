$(function(){
  // カテゴリーのセレクトボックスのオプション（セレクトボックス内に表示させる候補）
  function appendOption(category){
    var html = `<option data-category="${category.name}" value= "${category.id}">${category.name}</option>`;
    return html;
  }

  //子カテゴリーの表示を作成
  function appendChildrenBox(insertHTML){
    var childSelectHtml = `<select prompt="---" id="child_category" class="item-name">
                         <option value="---">---</option>
                         ${insertHTML}
                       </div>
                       `
    $('.category_form').append(childSelectHtml);
  }

  // //孫カテゴリーの表示作成
  function appendGrandChildrenBox(insertHTML){
    var grandchildSelectHtml = `<select prompt="---" id="grandchild_category" name="item[category_id]" class="item-name">
                                  <option value="---">---</option>
                                  ${insertHTML}
                                </div>`
    $('.category_form').append(grandchildSelectHtml);
  }

  // 親カテゴリー選択時のイベント
  $('#parent_category').on('change',function(){
    var parentCategory = document.getElementById('parent_category').value;
    console.log(parentCategory)
    if (parentCategory != "---"){

      // このif文が上手く機能していない
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })

      .done(function(children){
        console.log(children)
        // 上記childrenは、get_category_childrenアクションで生成したchildrenの配列（json形式）。
        $('#child_category').remove();
        $('#grandchild_category').remove();
        $('.edit_child_category').remove();
        $('.edit_grandchild_category').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        // ↑子カテゴリーの名前が入ったhtmlを返す
        appendChildrenBox(insertHTML);
      })

        .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })

    }else{
      $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchild_category').remove();
    }
  });

  
  // 子カテゴリー選択時のイベント
  $(document).on('change','#child_category',function(){
    var childCategory = document.getElementById('child_category').value;
    $('.edit_grandchild_category').remove();
    if (childCategory != "---"){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childCategory },
        dataType: 'json'
      })

      .done(function(grandchildren){
        // 上記grandchildrenは、get_category_grandchildrenアクションで生成したgrandchildrenの配列（json形式）。
        $('#grandchild_category').remove();     
        $('#edit_grandchild_category').remove();
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        // ↑子カテゴリーの名前が入ったhtmlを返す
        appendGrandChildrenBox(insertHTML);
      })
  
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })

    }else{
      $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchild_category').remove();
    }

  });
});

