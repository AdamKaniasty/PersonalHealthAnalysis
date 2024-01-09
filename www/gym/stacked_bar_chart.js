r2d3.onRender(function (data, svg, width, height, options) {
	var margin = { top: 40, right: 10, bottom: 20, left: 30 },
		plotWidth = width - margin.left - margin.right,
		plotHeight = height - margin.top - margin.bottom;

	var seriesNames = Object.keys(data[0]).slice(2); // Assuming first two columns are 'year' and 'week'

	var stack = d3
		.stack()
		.keys(seriesNames)
		.order(d3.stackOrderNone)
		.offset(d3.stackOffsetNone);

	var layers = stack(data);

	var x = d3
		.scaleBand()
		.domain(data.map((d) => `${d.year} W${d.week}`))
		.rangeRound([0, plotWidth])
		.padding(0.1);

	var y = d3
		.scaleLinear()
		.domain([0, d3.max(layers, (layer) => d3.max(layer, (d) => d[1]))])
		.range([plotHeight, 0]);

	var color = d3.scaleOrdinal(d3.schemeCategory10).domain(seriesNames);

	var g = svg
		.append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	var layer = g
		.selectAll(".layer")
		.data(layers)
		.enter()
		.append("g")
		.attr("class", "layer")
		.style("fill", function (d, i) {
			return color(i);
		});

	var rect = layer
		.selectAll("rect")
		.data(function (d) {
			return d;
		})
		.enter()
		.append("rect")
		.attr("x", function (d) {
			return x(`${d.data.year} W${d.data.week}`);
		})
		.attr("y", function (d) {
			return y(d[1]);
		})
		.attr("height", function (d) {
			return y(d[0]) - y(d[1]);
		})
		.attr("width", x.bandwidth());

	// Axis Styling
	g.append("g")
		.attr("class", "axis axis--x")
		.attr("transform", "translate(0," + plotHeight + ")")
		.style("font-size", "12px")
		.style("color", "#4a4a4a")
		.call(d3.axisBottom(x));

	g.append("g")
		.attr("class", "axis axis--y")
		.style("font-size", "12px")
		.style("color", "#4a4a4a")
		.call(d3.axisLeft(y));

	// Adding Labels to Bars
	layer
		.selectAll("text")
		.data(function (d) {
			return d;
		})
		.enter()
		.append("text")
		.attr("x", function (d) {
			return x(`${d.data.year} W${d.data.week}`) + x.bandwidth() / 2;
		})
		.attr("y", function (d) {
			return y(d[1]) + (y(d[0]) - y(d[1])) / 2;
		})
		.attr("dy", "0.35em")
		.attr("text-anchor", "middle")
		.text(function (d) {
			return d[1] - d[0] > 0 ? d3.format(".2s")(d[1] - d[0]) : "";
		})
		.style("fill", "#fff")
		.style("font-size", "10px");

	// Tooltip
	var tooltip = d3
		.select("body")
		.append("div")
		.attr("class", "tooltip")
		.style("opacity", 0);

	rect
		.on("mouseover", function (d) {
			tooltip.transition().duration(200).style("opacity", 0.9);
			tooltip
				.html("Total Weight: " + (d[1] - d[0]))
				.style("left", d3.event.pageX + "px")
				.style("top", d3.event.pageY - 28 + "px");
		})
		.on("mouseout", function (d) {
			tooltip.transition().duration(500).style("opacity", 0);
		});
});
