#import "src/lib.typ": tufte, sidenote, sidecite

#show: tufte.with(
  title: [Нормальное распределение],
  author: "Винни-Пух",
  date: datetime.today(),
  bib: bibliography("refs.bib"),
)


// #import "@preview/ctheorems:1.1.3": *
// #show: thmrules.with(qed-symbol: $square$)

// Define theorem environments
// #let theorem = thmbox("theorem", "Теорема", fill: rgb("#e8f4f8"))
// "идентификатор для нумерации", "Название"
// #let lemma = thmbox("theorem", "Лемма", base: "theorem", fill: rgb("#fef3e2"))
// #let definition = thmbox("definition", "Определение", inset: (x: 1.2em, top: 1em))
// #let proof = thmproof("proof", "Доказательство")


#import "@preview/theorion:0.6.0": *
// #import cosmos.simple: *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion



// код ближе к тексту! лучше Norm вместо dNorm?
// пока для страховки и Norm и dNorm, позже решим, но похоже Norm лучше.
#let Var = math.op("Var")
#let calF = math.cal("F")
#let dBin = math.op("Bin")
#let Mix = math.op("Mix")
#let dNorm = math.op("Norm")
#let Norm = math.op("Norm")
#let dUnif = math.op("Unif")
#let Unif = math.op("Unif")
#let dExpo = math.op("Expon")
#let Expon = math.op("Expon")
#let Span = math.op("Span")

// #link("https://tex.stackexchange.com/questions/14821/whats-the-proper-way-to-typeset-a-differential-operator")
// Длинная дискуссия о том, как правильно писать dx :) Я — в банде Косых!
#let dq = $d q$ // = $dif q$
#let dx = $d x$ // = $dif x$
#let df = $d f$ // = $dif f$

#let disteq = $~$ // мбыть поменяем на что-то более красивое :)

#let const = $c o n s t$

// сердечко же!
#let loveq = $limits(=)^(#text(fill: red, size: 0.8em, sym.suit.heart.filled))$




// нумеруем только уравнения с меткой типа <eq:метка>
// https://forum.typst.app/t/how-to-conditionally-enable-equation-numbering-for-labeled-equations/977/2

#show: body => {
  for elem in body.children {
    if elem.func() == math.equation and elem.block {
      let numbering = if "label" in elem.fields().keys() { "(1)" } else { none }
      set math.equation(numbering: numbering)
      elem
    } else {
      elem
    }
  }
}





= От аксиом Гершеля-Максвелла к дифференциальному уравнению

Представим себе, что мы поймали одну из молекул кислорода, летающую в закрытой комнате.
Для простоты изложения будем считать, что комната плоская и у пойманной молекулы всего две компоненты скорости, $(X, Y)$.
Что разумно предположить про закон распределения этого вектора?

Комната закрыта, ветра нет, поэтому разумно предположить, что молекулы движутся случайно, не предпочитая ни одно из направлений.
Это означает, что при повороте вектора $(X, Y)$ на любой фиксированный угол закон распределения вектора не изменяется.

Кроме того, разумно предположить, что компоненты скорости независимы: если мы знаем, что молекула летит к югу по оси север-юг, это не несёт нам информации о направлении молекулы по оси запад-восток. 

Эти две предпосылки назовём аксиомами Гершеля-Максвелла.

#definition["Аксиомы Гершеля-Максвелла"][
1. Закон распределения вектора $(X, Y)$ инвариантен к повороту на любой фиксированный угол. 

2. Компоненты вектора независимы. 
] <def:herschel-maxwell>

Оказывается, этих двух предпосылок достаточно, чтобы получить функцию плотности вектора $(X, Y)$.
Для начала попробуем простые следствия. 

Если повернуть вектор $(X, Y)$ на $180°$, то он превратиться в вектор $(-X, -Y)$. 
Следовательно, закон распределения величины $X$ и величины $(-X)$ одинаковый, $X disteq -X$.

Если повернуть вектор $(X, Y)$ на $90°$ против часовой стрелке, то он превратиться в вектор $(-Y, X)$. 
Отсюда мы получаем ещё пару совпадений законов распределения, $X disteq -Y$ и $Y disteq X$.

todo: тут картинка

Предположим дополнительно, что у вектора $(X, Y)$ есть совместная функция плотности $f(x, y)$.
Строго говоря, существование плотности тоже можно вывести из аксиом Гершеля-Максвелла, но я не знаю как это изложить легко и доступно#sidenote[todo ссылка].  

Немножко заабьюзим букву $f$ и будем использовать её как для совместной плотности пары величин, $f(x, y)$, так и для индивидуальной плотности $f(x)$. 
В силу одинаковости распределения компонент скорости $X$ и $Y$ и их независимости,
$
  f(x) dot f(y) = f(x, y).
$
Прологарифмируем,
$ 
ln f(x) + ln f(y) = ln f(x, y). 
$
Для распределения инвариантного к повороту ни левая, ни правая части не зависит от угла $phi$.
Продифференцируем обе части по углу $phi$,
$ 
  frac(f'(x), f(x)) dot frac(d x, d phi) + frac(f'(y), f(y)) dot frac(d y, d phi) = 0. 
$
Или
$ 
  frac(f'(x), f(x)) dot (-y) + frac(f'(y), f(y)) dot x = 0. 
$
Разнесём $x$ и $y$ по разным частям уравнения
$ 
  frac(f'(x), f(x)) dot y = frac(f'(y), f(y)) dot x.
$
Или
$
  frac(y f(y), f'(y)) = frac(x f(x), f'(x)).
$
Это не уравнение, связывающее величины $x$ и $y$, а тождество, верное при любых $x$ и $y$.
Левая часть тождества зависит только от $x$, правая — только от $y$, следовательно, тождество возможно, только если обе части равны константе.

$
  frac(x f(x), f'(x)) = const.
$

Сначала задумаемся о знаке константы в правой части.
Если константа положительна, то при $x > 0$ производная $f'(x) > 0$ и функция плотности $f(x)$ возрастает,
а при $x < 0$, наоборот, $f'(x) < 0$ и график $f(x)$ убывает.
Гипотетически, при положительной константе функция $f(x)$ выглядела бы примерно так,

todo: тут гипотетический график

Конечно, такой график для функции плотности невозможен в силу того, что площадь под функцией плотности должна равняться единице, $integral_(-oo)^(+oo) f(x) dx = 1$.
Следовательно, константа в правой части тождества отрицательная, а график плотности убывает справа от нуля и возрастает слева.

todo: тут верная картинка

Заметим, что при $x -> +oo$ или при $x -> -oo$ функция плотности должна убывать до нуля, иначе мы не получим единичную площадь под плотностью.

todo: на полях ещё одна гипотетическая картинка, где плотность убывает не до нуля.


Теперь задумаемся о единицах измерения константы.
Величина $x$ — это скорость молекулы по горизонтали.
Будем измерять её в метрах в секунду.
Маленькая разница $dx$ тогда тоже измеряется в метрах в секунду.
Вероятность попадания в малый отрезок выражется через функцию плотности,
$
  PP(X in [x, x + dx]) loveq f(x) dot dx.
$
Вероятность не имеет единиц измерения, $dx$ измеряется в метрах в секунду, поэтому функция плотности $f(x)$ измеряется в обратных единицах измерения по сравнению с исходной величиной $x$, в нашем случае плотность измеряется в $("м/сек")^(-1)$.
Производная $f'(x) = df(x)/dx$ измеряется в $("м/сек")^(-2)$.

Следовательно, дробь $frac(x f(x), f'(x))$ равна отрицательной константе с размерностью $("м/сек")^2$.
Поэтому давайте обозначим константу $const$ в правой части как $-sigma^2$:

$
  frac(x f(x), f'(x)) = - sigma^2.
$

Это опорное дифференциальное уравнение.
Этого уравнения и равенства площади под плотностью единице, $integral_(-oo)^(+oo) f(x) dx = 1$, достаточно, чтобы найти функцию плотности в явном виде.

= От дифференциального уравнения к свойствам

Для решения уравнения заметим, что дробь $frac(f'(x), f(x), style: "horizontal")$ можно записать как $(ln f(x))'$.
Кстати, производная $f'(x)$ измеряет скорость изменения функции, а дробь $frac(f'(x), f(x), style: "horizontal")$ измеряет скорость изменения в функции в долях (или в процентах) от текущего значения функции $f(x)$.#sidenote[Например, если $f'(x) = 0.01$, то при единичном изменении $x$ плотность вырастет примерно на $0.01$,
а если $frac(f'(x), f(x), style: "horizontal") = 0.01$, то при единичном изменении $x$ плотность вырастет примерно на $1%$.]
$
  frac(x, (ln f(x))') = -sigma^2.
$
Выражаем производную логарифма плотности,
$
  (ln f(x))' = -frac(x, sigma^2).
$
Восстанавливаем логарифм плотности
$
  ln f(x) = c  - frac(x^2, 2 sigma^2)
$
и саму функцию плотности
$
  f(x) = d dot exp(-x^2/(2 sigma^2)).
$
Совместная плотность вектора $(X, Y)$ равна произведению индивидуальных,
$
  f(x, y) =  f(x) dot f(y) =  d^2 exp(- (x^2 + y^2)/(2 sigma^2)).
$

Процитируем полностью текст из работы Гершеля #sidecite(<herschel1869onprobabilities>). 
Это просто фантастика по современным меркам. 
Он получает ту же формулу с суммой квадратов $x$ и $y$ внутри экспоненты обходясь словами!

We set out from three postulates. 1st, that the probability of a compound event, or of the concurrence of two or more independent simple events, is the product of the probabilities of its constituents considered singly; 2dly, that there exists a relation or numerical law of connexion (at present unknown) between the amount of error committed in any numerical determination and the probability of committing it, such that the greater the error the less its probability, according to some regular LAW of progression, *which must necessarily be general and apply alike to all cases, since the causes of error are supposed alike unknown in all; and it is on this ignorance, and not upon any peculiarity in cases, that the idea of probability in the abstract is founded*; 3dly, that the errors are equally probable if equal in numerical amount, whether in excess, or in defect of, or in any way beside the truth. This latter postulate necessitates our assuming the function of probability to be what is called in mathematical language *an even function, or a function of the square of the error*, so as to be alike for positive and negative values; and the postulate itself is nothing more than the expression of our state of *complete ignorance* of the causes of error, and their mode of action. To determine the form of this function, we will consider a case in which the relations of space are concerned.

Suppose a ball dropped from a given height, with the intention that it shall fall on a given mark. Fall as it may, its deviation from the mark is *error*, and the probability of that error is the unknown function of its square, *i. e.* of the sum of the squares of its deviations in any two rectangular directions. Now, the probability of any deviation depending solely on its *magnitude*, and not on its direction, it follows that the probability of each of these rectangular deviations must be the same function of its square. And since the observed oblique deviation is equivalent to the two rectangular ones, supposed concurrent, and which are essentially independent of one another, and is, therefore, a compound event of which they are the simple independent constituents, therefore its probability will be the product of their separate probabilities. Thus the form of our unknown function comes to be determined from this condition, viz., that the product of such functions of two independent elements is equal to the same function of their sum. But it is shown in every work on algebra that this property is the peculiar characteristic of, and belongs only to, the exponential or antilogarithmic function. This, then, is the function of the square of the error, which expresses the probability of committing that error. That probability decreases, therefore, in geometrical progression, as the square of the error increases in arithmetical. And hence it further follows, that the probability of successively committing any given system of errors on repetition of the trial, being, by postulate I., the product of their separate probabilities, must be expressed by the same exponential function of the sum of their squares however numerous, and is, therefore, a maximum when that sum is a minimum.

Интересно заметить, что с точки зрения Гершеля, формула $PP(A inter B) = PP(A) dot PP(B)$ для независимых событий $A$ и $B$ — это первая аксиома, которую надо явно проговорить. 


Немного забегая вперёд скажем, что из условия нормировки $integral_(-oo)^(+oo) f(x) dx = 1$
следует, что константы в общем решении дифференциального уравнения равны
$
c = ln f(0) = - frac(ln pi + ln (sigma^2), 2) quad "и" quad d = f(0) = frac(1, sqrt(2 pi sigma^2)),
$
а функция плотности, соответственно, равна
$
  f(x) = frac(1, sqrt(2 pi sigma^2)) exp(-x^2/2 sigma^2).
$

Однако оказывается, что полезные свойства распределения гораздо проще установить исходя из аксиом или дифференциального уравнения, а не из явного вида плотности!

Найдём ожидания $EE(X)$ и $EE(abs(X))$, дисперсию $Var(X)$, точки перегиба функции плотности $f(x)$ и нарисуем график функции плотности $f(x)$.


Прежде всего, заметим, что график плотности должен быть симметричен относительно вертикальной оси $x=0$.
Это следует из предпосылки об инвариантности распределения вектора $(X, Y)$ при повороте.
Поворачиваясь на $180°$, мы превращаем измеряемую скорость $X$ в скорость $-X$, поэтому функция плотности у величины $X$ и у величины $(-X)$ должна быть одинаковая.
Из одинакового закона распределения величин $X$ и $-X$ математическое ожидание $EE(X)$ должно равняться нулю, либо не существовать.
Мы уже знакомы [todo: проверить порядок изложения] с распределением Коши, у которого функция плотности симметрична относительно нуля, однако ожидание не существует.
Чтобы выяснить, существует ли ожидание в данном случае, воспользуемся формулой для ожидания и дифференциальным уравнением:
$
  EE(X) = integral_(-oo)^(+oo) x f(x) dx = - sigma^2 integral_(-oo)^(+oo) f'(x) dx = -sigma^2 (f(+oo) - f(-oo)).
$
Мы уже знаем, что $f(+oo) = f(-oo) = 0$, следовательно, ожидание существует и равно $EE(X) = 0$.

Найдём дисперсию! Для этого снова воспользуемся дифференциальным уравнением:
$
  Var(X) = EE(X^2) - (EE X)^2 = EE(X^2) = integral_(-oo)^(+oo) x^2 f(x) dx = -sigma^2 integral_(-oo)^(+oo) x f'(x) dx.
$
Возьмём требуемый интеграл по частям:
$
   integral_(-oo)^(+oo) x f'(x) dx = [x f(x)]^(+oo)_(-oo) - integral_(-oo)^(+oo) f(x) dx.
$
Уменьшаемое $[x f(x)]^(+oo)_(-oo)$ равно нулю в силу того, что экспонента растёт быстрее любого многочлена,
$
  lim_(x -> oo) x f(x) = lim_(x -> oo) frac(x, d dot exp(x^2/2 sigma^2)) = 0.
$
Вычитаемое $integral_(-oo)^(+oo) f(x) dx$ равно единице как площадь под функцией плотности.
Мы можем завершить нахождение дисперсии
$
  Var(X) = -sigma^2 integral_(-oo)^(+oo) x f'(x) dx = -sigma^2 ( 0 - 1) = sigma^2.
$
Теперь с полным правом можем дать определение нормальной случайной величины.

Определение. Случайная величина $X$, чья функция плотности $f(x)$ удовлетворяет дифференциальному уравнению
$
  frac(x f(x), f'(x)) = -sigma^2,
$
называется нормальной случайной величиной с ожиданием $0$ и дисперсией $sigma^2$ и обозначается $Norm(0, sigma^2)$.

Найдём точки перегиба функции плотности, для этого выразим производную плотности из определения,
$
  f'(x) = -frac(x f(x), sigma^2),
$
продифференцируем её ещё раз и снова воспользуемся дифференциальным уравнением,
$
  f''(x) = -frac(f(x) + x f'(x), sigma^2) = -frac(f(x) + x^2 f(x)/sigma^2, sigma^2).
$
В точке перегиба $f''(x) = 0$, что возможно только при $x = plus.minus sigma$.

Найдём ожидание модулю скорости, воспользовавшись симметрией плотности,
$
EE(abs(X)) = integral_(-oo)^(+oo) abs(x) f(x) dx = 2 integral_0^(+oo) x f(x) dx = -2 sigma^2 integral_0^(+oo) f'(x) dx = - 2 sigma^2 (f(+oo) - f(0)).
$
На бесконечности функция плотности обращается в ноль, поэтому среднее значение модуля скорости равно
$
  EE(abs(X)) = 2 sigma^2 f(0).
$
Используем данное нами ранее обещание, что константа в решении дифференциального уравнения равна
$
d = f(0) = frac(1, sqrt(2 pi sigma^2)),
$
мы получаем, что средний модуль скорости молекулы равен
$
  EE(abs(X)) = 2 sigma^2 f(0) = sigma sqrt(frac(2, pi)) approx 0.80 sigma.
$
Проговорим интерпретацию словами.
Константа $sigma^2$ — это дисперсия скорости молекулы,
кроме того, $sigma$ — это примерно 125% от среднего модуля скорости.


При нахождении ожиданий мы уже пару раз пользовались приятной связкой дифференциального уравнения и интегрирования по частям.
В силу дифференциального уравнения можно перейти от произведения $x f(x)$ к производной $f'(x)$, к которой удобно применять формулу интегрирования по частям.
Давайте оформим эту связку в виде леммы.

К примеру мы хотим найти ожидание $EE(X dot h(X))$. Начнём его искать:
$
  EE(h(X)) = integral_(-oo)^(+oo) x h(x) f(x) dx = -sigma^2 integral_(-oo)^(+oo) h(x) f'(x) dx.
$
Если функция $h(x)$ не слишком быстро растёт #sidenote[Например, подойдут любые многочлены, произведения многочленов с синусами или косинусами...], а именно, если
$
  lim_(-oo) h(x) f(x) = 0  quad "и" quad lim_(+oo) h(x) f(x) = 0,
$
то формула интегрирования по частям теряет первое слагаемое $[h(x) f(x)]^(+oo)_(-oo)$ и упрощается до
$
  integral_(-oo)^(+oo) h(x) f'(x) dx = 0 - integral_(-oo)^(+oo) h'(x) f(x) dx = - EE(h'(X)).
$

Мы получили лемму Стейна.

#lemma["Лемма Стейна"][Если величина $X$ имеет нормальное распределение $Norm(0, sigma^2)$ и функция $h(x)$ не слишком быстро растёт на плюс-минус бесконечности, а именно, если#sidenote[Под $f(x)$ мы подразумеваем функцию плотности.] $lim_(x -> +oo) h(x) f(x) = lim_(x -> -oo) h(x) f(x) = 0$, то
$
  EE(X dot h(X)) = sigma^2 EE(h'(X)).
$
]
Например, по лемме Стейна можно очень быстро посчитать ожидание и дисперсию, если вдруг кто-то успел их забыть :)
$
  EE(X) = EE(X dot 1) = sigma^2 EE(1') = EE(0) = 0.
$
И, дисперсия,
$
  EE(X^2) = EE(X dot X) = sigma^2 EE(X') = sigma^2 EE(1) = sigma^2.
$
А если серьёзно, то можно найти ожидание любого момента для нормальной $Norm(0, sigma^2)$ величины.
Третий момент,
$
  EE(X^3) = EE(X dot X^2) = sigma^2 EE(2 X) = 0.
$
Четвёртый момент,
$
  EE(X^4) = EE(X dot X^3) = sigma^2 EE(3 X^2) = 3 sigma^4.
$
Нетрудно заметить, что удаление одного сомножителя $X$ у $X^n$ и последующее взятие производной снижает степень у $X$ на два и выносит вперёд сомножитель $(n-1) sigma^2$.
$
 EE(X^n) = EE(X dot X^(n-1)) = sigma^2 EE((n-1) X^(n-2)) = (n-1) sigma^2 EE(X^(n-2)).
$
Следовательно, для любой чётной степени $n=2k$ получаем
$
  EE(X^(2k)) = (2k-1)(2k-3) dots 3 dot 1 dot sigma^(2k),
$
что компактно записывают с помощью двойного факториала,
$
  EE(X^(2k)) = (2k-1)!! dot sigma^(2k).
$

А для нечётных степеней $EE(X^(2k-1)) = 0$ в силу одинаковости распределения $X$ и $-X$.








Найдём производящую функцию для нормального распределения.
По определению производящей функции,
$
  g(t) = EE(exp(t X)).
$
Перед нами ну почти лемма Стейна, не хватает только величины $X$ внутри ожидания, давайте этого кукушонка туда подбросим! Применим трюк Фейнмана и возьмём слева и справа производную по $t$.
$
  g'(t) = EE(exp(t X) dot X).
$
Следите за руками, теперь мы будем применять лемму Стейна, а в ней фигурирует производная по $X$!
$
  g'(t) = EE(exp(t X) dot X) = sigma^2 EE(d exp(t X)/d X) = sigma^2 EE(exp(t X) t) = t sigma^2 g(t).
$
Отсюда, мы получаем дифференциальное уравнение на производящую функцию $g(t)$,
$
  frac(g'(t), g(t)) = t sigma^2 "с начальным условием" g(0) = 1.
$
Да это же брат-близнец дифференциального уравнение для функции плотности,
$
  frac(f'(x), f(x)) = - x frac(1, sigma^2) "с начальным условием" f(0) = 1/sqrt(2 pi sigma^2).
$
Только константа $sigma^2$ не в знаменателе теперь, а в числителе, да знак минус исчез.
Поэтому, совершенно аналогично, сделав ту же замену $frac(g'(t), g(t)) = (ln g(t))'$ можно явно найти производящую моменты функцию,
$
  g(t) = exp(sigma^2 t^2 / 2).
$
Разложим нашу функцию $g(t)$ в ряд Тейлора, чтобы ещё одним путём увидеть моменты $EE(X^k)$:
$
  g(t) = 1 + 0 dot t + frac(sigma^2, 2) t^2 + 0 dot t^3 + (frac(sigma^2, 2))^2 frac(1, 2!) t^4 +  0 dot t^5 + (frac(sigma^2, 2))^3 frac(1, 3!) t^6 + dots
$
Напомним, что любая производящая моменты функция раскладывается в ряд как
$
  g(t) = 1 + EE(X) dot t + EE(X^2) dot frac(1, 2!) t^2 + EE(X^3) dot frac(1, 3!) t^2  + EE(X^4) dot frac(1, 4!) t^4  + EE(X^5) dot frac(1, 5!) t^5  + EE(X^6) dot frac(1, 6!) t^6  + dots
$
И мы снова видим, что все нечётный моменты для нормальной $Norm(0, sigma^2)$ величины равны нулю, например, $EE(X^5) = 0$, а нечётные — положительны.
Посмотрим, например, на шестой момент,
$
  EE(X^6) = frac(6!, 2^3 dot 3!) sigma^6 = frac(6 dot 5 dot 4 dot 3 dot 2 dot 1, 2 dot 2 dot 2 dot 3 dot 2 dot 1) sigma^6.
$
Из факторила $6!$ в числителе знаменатель сократит все чётные числа, и после сокращения останется $5!! = 5 dot 3 dot 1$, то есть,
$
  EE(X^6) = 5!! sigma^6.
$
В общем случае, как и через лемму Стейна, получаем $EE(X^(2k)) = (2k - 1)!! sigma^6$.









Естественно, если сместить функцию вправо на $mu$, то мы сохраним дисперсию, а математическое ожидание новой величины окажется равным $mu$.

Определение. Случайная величина $X$, чья функция плотности $f(x)$ удовлетворяет дифференциальному уравнению
$
  frac((x-mu) f(x-mu), f'(x-mu)) = -sigma^2,
$
называется нормальной случайной величиной с ожиданием $mu$ и дисперсией $sigma^2$ и обозначается $X disteq Norm(mu, sigma^2)$.





Чтобы быть в числе благородных донов остаётся доказать, что из условия единичной площади под функцией плотности следует, что нормировочная константа равна именно $frac(1, sqrt(2 pi sigma^2))$.




Лог функции плотности убывает со всё растущей скоростью.
Следовательно, плотность убывает в ноль. Плотность помножить на любой многочлен убывает в ноль.




График, иллюстрирующий быстроту убывания, парабола под графиком плотности, шаг по вертикали $2 ln(2) approx 1.4$.

Нахождение константы: графическое свойство экспоненты: площадь и длина тени касательной. Принцип Мамикона.


Вывод, что X^2 + Y^2 имеет экспоненциальное распределения с помощью о-малых и вероятности попасть в кольцо площади $pi dot dq$.

$Q = R^2 = X^2 + Y^2$

$ PP(Q in [q; q + dq]) = f(x, y) dot pi dot dq = f(sqrt(Q), 0) dot pi dot dq = 1/2 exp(-q/2) dot dq $

$X^2 + Y^2 ~ Expon(lambda = 1/2)$


Теорема Иссерлиса. Сначала изложение обозначений $mu_i$, $c_(i j)$.
Затем вывод формулы для $EE(Y_1 Y_2 Y_3)$ через симметрию.
Догадка об отсутствии дисперсии и многочлене с единичными коэффициентами.
Доказательство отсутствия дисперсии. Доказательство вида. Нахождение коэффициентов.



Свойства нормального распределения!

Из геометрии следует: при масштабировании предпосылки сохраняются. Любая линейная комбинация нормальных тоже нормальна.


