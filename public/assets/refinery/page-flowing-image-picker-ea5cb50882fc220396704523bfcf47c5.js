$(document).ready(function(){$("#custom_images_tab a").click(function(){(picker=$("#page_flowing_image_picker")).data("size-applied")||(wym_box=$(".page_part:first .wym_box"),iframe=$(".page_part:first iframe"),picker.css({height:wym_box.height(),width:wym_box.width()}).data("size-applied",!0).corner("tr 5px").corner("bottom 5px").find(".wym_box").css({backgroundColor:"white",height:iframe.height()+$(".page_part:first .wym_area_top").height()-parseInt($(".wym_area_top .label_inline_with_link a").css("lineHeight")),width:iframe.width()-20,"border-color":iframe.css("border-top-color"),"border-style":iframe.css("border-top-style"),"border-width":iframe.css("border-top-width"),padding:"0px 10px 0px 10px"}))}),$("#content #page_flowing_images li textarea:hidden").each(function(a){var b=$(this).attr("name");$(this).attr("data-old-id",$(this).attr("id")),$(this).attr("name","ignore_me_"+a),$(this).attr("id","ignore_me_"+a);var c=$("<input>").addClass("caption").attr("type","hidden").attr("name",b).attr("id",$(this).attr("data-old-id")).val($(this).val());$(this).parents("li").first().append(c)}),$("#content #page_flowing_images li input.page_weblink").each(function(a){var b=$(this).attr("name");$(this).attr("data-old-id",$(this).attr("id")),$(this).attr("name","ignor_me_"+a),$(this).attr("id","ignor_me_"+a);var c=$("<input>").addClass("weblink").attr("type","hidden").attr("name",b).attr("id",$(this).attr("data-old-id")).val($(this).val());$(this).parents("li").first().append(c)}),flowing_reset_functionality()}),flowing_reset_functionality=function(){WYMeditor.onload_functions.push(function(){$(".wym_box").css({width:null})}),$("#page_flowing_images").sortable({tolerance:"pointer",placeholder:"placeholder",cursor:"drag",items:"li",stop:flowing_reindex_images}),$("#content #page_flowing_images li:not(.empty)").live("hover",function(a){a.type=="mouseenter"||a.type=="mouseover"?((image_actions=$(this).find(".image_actions")).length==0&&(image_actions=$("<div class='image_actions'></div>"),img_delete=$("<img src='/assets/refinery/icons/delete.png' width='16' height='16' />"),img_delete.appendTo(image_actions),img_delete.click(function(){$(this).parents("li").first().remove(),flowing_reindex_images()}),$(this).find("textarea.page_caption").length>0?(img_caption=$("<img src='/assets/refinery/icons/user_comment.png' width='16' height='16' class='caption' />"),img_caption.appendTo(image_actions),img_caption.click(flowing_open_image_caption)):image_actions.addClass("no_captions"),$(this).find("input.page_weblink").length>0&&(img_weblink=$("<img src='/assets/refinery/icons/application_go.png' width='16' height='16' class='weblink' />"),img_weblink.appendTo(image_actions),img_weblink.click(flowing_open_image_weblink)),image_actions.appendTo($(this))),image_actions.show()):(a.type=="mouseleave"||a.type=="mouseout")&&$(this).find(".image_actions").hide()}),flowing_reindex_images()},flowing_image_added=function(a){new_list_item=(current_list_item=$("li.empty.flowing")).clone(),image_id=$(a).attr("id").replace("image_",""),current_list_item.find("input:hidden:first").val(image_id),$("<img />").attr({title:$(a).attr("title"),alt:$(a).attr("alt"),src:$(a).attr("data-grid")}).appendTo(current_list_item),current_list_item.attr("id","flowing-image_"+image_id).removeClass("empty flowing"),new_list_item.appendTo($("#page_flowing_images")),flowing_reset_functionality()},flowing_open_image_caption=function(a){(list_item=$(this).parents("li").first()).addClass("current_caption_list_item"),textarea=list_item.find(".textarea_wrapper_for_wym > textarea"),textarea.after($("<div class='form-actions'><div class='form-actions-left'><a class='button'>Done</a></div></div>")),textarea.parent().dialog({title:"Add text to image",modal:!0,resizable:!1,autoOpen:!0,width:928,height:530}),$(".ui-dialog:visible .ui-dialog-titlebar-close, .ui-dialog:visible .form-actions a.button").on("click",$.proxy(function(a){$(this).data("wymeditor").update(),$(this).removeClass("wymeditor").removeClass("active_rotator_wymeditor"),$this_parent=$(this).parent(),$this_parent.appendTo("li.current_caption_list_item").dialog("close").data("dialog",null),$this_parent.find(".form-actions").remove(),$this_parent.find(".wym_box").remove(),$this_parent.css("height","auto"),$this_parent.removeClass("ui-dialog-content").removeClass("ui-widget-content"),$("li.current_caption_list_item").removeClass("current_caption_list_item"),$(".ui-dialog, .ui-widget-overlay:visible").remove(),$("#"+$(this).attr("data-old-id")).val($(this).val())},textarea)),textarea.addClass("wymeditor active_rotator_wymeditor widest").wymeditor(wymeditor_boot_options)},flowing_reindex_images=function(){$("#page_flowing_images li textarea:hidden").each(function(a,b){parts=$(b).attr("name").split("_"),parts[2]=""+a,$(b).attr("name",parts.join("_")),$(b).attr("id",$(b).attr("id").replace(/_\d/,"_"+a)),$(b).attr("data-old-id",$(b).attr("data-old-id").replace(/_\d_/,"_"+a+"_").replace(/_\d/,"_"+a))}),$("#page_flowing_images li input.page_weblink").each(function(a,b){parts=$(b).attr("name").split("_"),parts[2]=""+a,$(b).attr("name",parts.join("_")),$(b).attr("id",$(b).attr("id").replace(/_\d/,"_"+a)),$(b).attr("data-old-id",$(b).attr("data-old-id").replace(/_\d_/,"_"+a+"_").replace(/_\d/,"_"+a))}),$("#page_flowing_images li").each(function(a,b){$("input:hidden",b).each(function(){$(this).attr("class")!="page_weblink"&&(parts=$(this).attr("name").split("]"),parts[1]="["+a,$(this).attr("name",parts.join("]")),$(this).attr("id",$(this).attr("id").replace(/_\d_/,"_"+a+"_").replace(/_\d/,"_"+a)))})})},flowing_open_image_weblink=function(a){(list_item=$(this).parents("li").first()).addClass("current_weblink_list_item"),input=list_item.find(".dialog > input"),input.after($("<div class='form-actions'><div class='form-actions-left'><a class='button'>Done</a></div></div>")),input.parent().dialog({title:"Add link to image",modal:!0,resizable:!1,autoOpen:!0,width:600,height:100,close:function(a,b){input.hide()}}),input.show(),$(".ui-dialog:visible .ui-dialog-titlebar-close, .ui-dialog:visible .form-actions a.button").on("click",$.proxy(function(a){$this_parent=$(this).parent(),$this_parent.appendTo("li.current_weblink_list_item").dialog("close").data("dialog",null),$this_parent.find(".form-actions").remove(),$this_parent.css("height","auto"),$this_parent.removeClass("ui-dialog-content").removeClass("ui-widget-content"),$("li.current_weblink_list_item").removeClass("current_weblink_list_item"),$(".ui-dialog, .ui-widget-overlay:visible").remove(),$("#"+$(this).attr("data-old-id")).val($(this).val())},input))};