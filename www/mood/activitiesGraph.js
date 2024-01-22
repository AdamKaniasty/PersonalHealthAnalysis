// activitiesGraph.js

// Initialization
svg.attr("font-family", "sans-serif")
  .attr("font-size", "16")
  .attr("text-anchor", "middle")
  .style("background-color", "transparent")
  .style("font-weight", "bold")
  .style("fill", "white");

var svgSize = 800;
var pack = d3.pack()
  .size([svgSize, svgSize-100])
  .padding(1.5);

var color = d3.scaleOrdinal(d3.schemeCategory20);

var group = svg.append("g");

// Resize
r2d3.onResize(function (width, height) {
  var minSize = Math.min(width, height);
  var scale = minSize / svgSize;

  group.attr("transform", "translate(" + (width - minSize) / 2 + "," + (height - minSize) / 2 + ")" +
    "scale(" + scale + "," + scale + ")");
});

// Rendering
r2d3.onRender(function (data, svg, width, height, options) {
  var root = d3.hierarchy({ children: data })
    .sum(function (d) { return d.frequency; });

  var nodes = pack(root).leaves();

  var node = group.selectAll(".node")
    .data(nodes)
    .enter().append("g")
    .attr("class", "node")
    .attr("transform", function (d) { return "translate(" + d.x*1.15 + "," + d.y*1.15 + ")"; });

  node.append("circle")
    .attr("id", function (d) { return "circle-" + d.data.activity; })
    .attr("r", function (d) { return d.r*1.15; })
    .style("fill", function (d) { return color(d.data.activity); });

  node.append("text")
    .attr("dy", ".3em")
    .style("text-anchor", "middle")
    .text(function (d) { return d.data.activity; });

  node.append("title")
    .text(function (d) { return d.data.activity + "\nFrequency: " + d.data.frequency; });
   

  r2d3.resize(width, height);
});

