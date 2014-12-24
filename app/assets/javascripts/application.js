function checkByParent(aId, aChecked) {
  var collection = document.getElementById(aId).getElementsByTagName('INPUT');
  for (var x=0; x<collection.length; x++) {
    if (collection[x].type.toUpperCase() === 'CHECKBOX')
      collection[x].checked = aChecked;
  }
}

function toggleDetailSection(section_id, event) {
    var section = document.getElementById(section_id);
    var classes = section.classList;
    if(classes.contains("hide"))
    {
        classes.remove("hide");
        event.currentTarget.innerHTML = '-';
    }else
    {
        classes.add("hide");
        event.currentTarget.innerHTML = '+';
    }
}

function highlightElement (element_id) {
    var elements = document.getElementsByTagName('rect');
    var element = null;
    var length = elements.length;

    for (var i = 0; i < length; i++) {
        elements[i].setAttribute("stroke-width", "1");
    }
    var this_element = document.getElementById(element_id);
    this_element.setAttribute("stroke-width", "5");
}

document.getElementById("changed_toggle").addEventListener("click", function(e) { toggleDetailSection('js--changed', e) });
document.getElementById("not_master_toggle").addEventListener("click", function(e) { toggleDetailSection('js--not_master', e) });
document.getElementById("not_current_toggle").addEventListener("click", function(e) { toggleDetailSection('js--not_current', e) });
