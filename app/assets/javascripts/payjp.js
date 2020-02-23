document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //id属性がtoken_submitの要素が存在すれば、下記コードを実施
      Payjp.setPublicKey("pk_test_0e17fba3d10886b3eddc8c95");
      let btn = document.getElementById("token_submit"); //id属性がtoken_submitである要素を取得し変数に代入
      btn.addEventListener("click", e => { 
        e.preventDefault(); 
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータを取得し、cardという変数に代入
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //保存に成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); 
            $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
            ); 
            document.inputForm.submit();
            alert("登録が完了しました"); 
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  },
  false
);