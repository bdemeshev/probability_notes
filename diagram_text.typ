#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#set page(width: auto, height: auto, margin: 5mm, fill: white)

#let nodes = ("a", "b", "c", "d", "e")
#let nodes_right = ("g", "h", "i", "j", "k")

#let to_cartesian(p) = (
  calc.cos(p.at(0)) * p.at(1),
  calc.sin(p.at(0)) * p.at(1),
)

#diagram({
	let nnodes = nodes.len()
	// left circle
	for (i, nodename) in nodes.enumerate() {
		let theta = 90deg - i*360deg/nnodes
		node((theta, 18mm), nodename, stroke: 0.5pt, name: str(i), shape: circle)

		let next_label = if (i + 1 < nnodes) {label(str(i + 1))} else {label(str(0))}
		edge(label(str(i)), next_label, "-|>")
	}
	// right circle
	for (i, nodename) in nodes_right.enumerate() {
		let theta = 90deg - i*360deg/nnodes
		node((rel: (60mm, 0mm), to: (theta, 18mm)), nodename, stroke: 0.5pt, name: str(i + nnodes), shape: circle)

		let next_label = if (i + 1 < nodes_right.len()) {label(str(i + 1 + nnodes))} else {label(str(nnodes))}
		edge(label(str(i + nnodes)), next_label, "-|>")
	}
	// bridge-node
	node((rel: (13mm, 0mm), to: (90deg - 360deg/nnodes, 18mm)), "f", stroke: 0.5pt, name: str(nodes_right.len() + nnodes), shape: circle)

	edge(label(str(1)), label(str(10)), bend: 15deg, "-|>")
	edge(label(str(10)), label(str(1)), bend: 15deg, "-|>")
	edge(label(str(10)), label(str(9)), bend: 15deg, "-|>")
	edge(label(str(9)), label(str(10)), bend: 15deg, "-|>")
})