#set page(paper: "a4")
#set heading()

#show link: set text(fill: blue, weight: 700)
#show link: underline

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

// код ближе к тексту! лучше Norm вместо dNorm?
// пока для страховки и Norm и dNorm, позже решим, но похоже Norm лучше.
#let calF = math.cal("F")

#let Var = math.op("Var")
#let dBin = math.op("Bin")
#let Mix = math.op("Mix")
#let dNorm = math.op("Norm")
#let Norm = math.op("Norm")
#let dUnif = math.op("Unif") // удалить!
#let Unif = math.op("Unif")
#let dExpo = math.op("Expon") // удалить!
#let Expon = math.op("Expon")
#let Span = math.op("Span")
#let size = math.op("size")
#let Truncated = math.op("Truncated")
#let sigmaw = math.op("Sigma")
#let Poisson = math.op("Poisson")
#let Fisher = math.op("Fisher")
#let Student = math.op("Student")
#let Chisq = math.op("ChiSq") // подумать???
#let SAlgebra = math.op("SAlgebra")




#let nodes = ("a", "b", "c", "d", "e")
#let nodes_right = ("g", "h", "i", "j", "k")

#let to_cartesian(p) = (
  calc.cos(p.at(0)) * p.at(1),
  calc.sin(p.at(0)) * p.at(1),
)



Задачка!

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

Предложите точку старта и бесконечный детерминированный маршрут по данному графу, следуя которому, путешественник будет посещать вершину (f) бесконечное количество раз, однако при этом проводить в вершине (f) нулевую долю своей  бесконечной жизни.
Какую долю своей жизни проведёт путешественник в каждой вершине?

Предложите такие вероятности на стрелочках и такую точку старта, чтобы полученная марковская цепь проводила $0.05$ своей бесконечной жизни в вершине (a) и нулевую долю своей жизни в вершине (f). 
Какую долю своей жизни построенная марковская цепь проведёт в каждой вершине?
