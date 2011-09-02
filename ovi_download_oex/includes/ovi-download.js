// ==UserScript==
// @include http://store.ovi.com/content*
// @include https://store.ovi.com/content*
// ==/UserScript==

window.onload = startScript;

function startScript(){
    var getULlist=document.getElementsByTagName('UL');
    for(var i=0;i<getULlist.length;i++){
        if(getULlist[i].className=='contentActions'){
            var DownloadButton = document.createElement('LI');
            DownloadButton.innerHTML='<a href="http://'+window.location.hostname+''+window.location.pathname+'/download" class="btnGraphic btnDownload">'+
            '<span class="overflow" style="padding-left:14px;padding-top:11px;width:auto!important;margin-right:30px;height:25px;" title="Download" >'+
            'Download.</span></a>';
            getULlist[i].insertBefore(DownloadButton, getULlist[i].firstChild);
        }
    }
}
