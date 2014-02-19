var kracker = {

    treeUp: function() {
        var treeWalker = document.createTreeWalker(
            document.body,
            NodeFilter.SHOW_ELEMENT,
            { acceptNode: function(node) { return NodeFilter.FILTER_ACCEPT; } },
            false
        );

        var nodeList = [];

        while(treeWalker.nextNode()){
            var cn = treeWalker.currentNode;
            var node_details = {
                "height"  : cn.clientHeight,
                "width"   : cn.clientWidth,
                "id"      : cn.id,
                "tag"     : cn.tagName,
                "class"   : cn.className,
              //"html"    : cn.innerHTML,
                "top"     : cn.offsetTop,
                "left"    : cn.offsetLeft,
                "visible" : kracker.isVisible(cn)
            }
            nodeList.push(node_details);
        }

        var resultsElement = document.createElement('textarea');

        resultsElement.style.marginLeft = 'auto';
        resultsElement.style.marginRight = 'auto';
        resultsElement.style.width = '100%';
        resultsElement.style.height = '400px';
        resultsElement.id = 'tree_results';
        resultsElement.textContent = JSON.stringify(nodeList, undefined, 2);
        document.getElementsByTagName('body')[0].appendChild(resultsElement);


        console.log(nodeList[0]);

        return(nodeList);
    },

    isVisible: function(elem) {
        return elem.offsetWidth > 0 || elem.offsetHeight > 0;
    }
};
