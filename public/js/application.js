$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()


  var checkobj

  function agreesubmit(el){
    checkobj=el
    if (document.all||document.getElementById){
      for (i=0;i<checkobj.form.length;i++){  //hunt down submit button
        var tempobj=checkobj.form.elements[i]
        if(tempobj.type.toLowerCase()=="submit")
          tempobj.disabled=!checkobj.checked
      }
    }
  }

  function defaultagree(el){
    if (!document.all&&!document.getElementById){
      if (window.checkobj&&checkobj.checked)
        return true
      else{
        alert("Please read/accept terms to submit form")
        return false
      }
    }
  }

});
