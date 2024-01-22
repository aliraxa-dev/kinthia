document.addEventListener("DOMContentLoaded", function(event) { 
  tinymce.init({
    selector: '.tinyMce',
    extended_valid_elements: 'span[*],i[*],pre[*],code[*],a[*]',
    relative_urls : false,
    remove_script_host : false,
    document_base_url : "https://www.kinthia.com/",
    width : "100%",
    height : "400",
    plugins: [
      'autolink lists charmap preview hr anchor pagebreak',
      'searchreplace wordcount visualblocks visualchars fullscreen insertdatetime nonbreaking',
      'table emoticons paste'
    ],
    toolbar: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | ' +
      'bullist numlist outdent indent',
    
  });
});