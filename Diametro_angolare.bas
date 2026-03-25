' Rappresentazione grafica del diametro angolare
' Marco da Venezia, 2008 (Prova per QB64)

' Finestra adattata al display
yDisplay = _DesktopHeight - 32
xDisplay = yDisplay * 16 / 9
Screen _NewImage(xDisplay, yDisplay, 256)
_ScreenMove 0, 0

Color 0, 7

Dim r As Double, D As Double

Do
    Cls
    View Print 1 To 1
    Input "Raggio dell'oggetto"; r
    If r <= 0 Then r = 1
    Print "Raggio:"; r;
    View Print 2 To 2
    Input "Distanza dall'oggetto"; D
    If D < r Then D = r ' forza il diametro angolare massimo a 180ø
    Print "Distanza:"; D;
    View Print
    If 2 * r > D * 9 / 16 Then scala = 2 * r / yDisplay Else scala = D / xDisplay ' adatta la scala alle dimensioni della finestra
    r = r / scala
    D = D / scala

    ' Coordinate osservatore e centro oggetto
    Dim xE As Double, yE As Double
    Dim xO As Double, yO As Double
    xE = 0: yE = yDisplay / 2
    xO = D: yO = yDisplay / 2

    ' Angolo tra la linea EO e la tangente (EA è speculare ad EB) ovvero mezzo diametro angolare
    Dim theta As Double
    theta = _Asin(r / D) ' radianti

    ' Angoli del raggio al punto di tangenza rispetto all'asse X
    ' L'angolo del raggio (O->A) è (PI/2 - theta) o (3*PI/2 + theta) per il punto B
    Dim A As Double ' Angolo raggio OA
    Dim B As Double ' Angolo raggio OB
    A = _Pi / 2 - theta ' Angolo in alto a sinistra
    B = _Pi / 2 + theta ' Angolo in basso a sinistra

    ' Punti di tangenza A e B (rispetto al centro O)
    Dim xA As Double, yA As Double
    Dim xB As Double, yB As Double

    ' Punti A e B sono sul CIRCLE a distanza 'r' dal centro (xO, yO)
    xA = xO - r * Cos(A) ' Il segno '-' è perché il centro O è a DESTRA di A
    yA = yO - r * Sin(A) ' Il segno '-' è perché O è PIÙ BASSO di A nel sistema di coordinate dello schermo
    xB = xA
    yB = yO + r * Sin(B)

    Line (0, yDisplay / 2)-(xDisplay, yDisplay / 2), _RGB(128, 128, 128) ' Asse orizzontale X
    Line (xO, 0)-(xO, yDisplay), _RGB(128, 128, 128) ' Asse verticale per il centro del cerchio

    ' Disegno Terra (occhio) e oggetto
    Circle (xE, yE), 10, _RGB(0, 255, 0) ' pupilla/iride
    Circle (xE, yE), 20, _RGB(0, 255, 0), , , 1.5 ' palpebre
    Circle (xO, yO), r, _RGB(0, 0, 255) ' Luna

    ' Tangenti dall'occhio ai punti A e B
    Line (xE, yE)-(xA, yA), _RGB(255, 0, 0)
    Line (xE, yE)-(xB, yB), _RGB(255, 0, 0)

    ' Segnapunti A e B sulla circonferenza
    Circle (xA, yA), 4, _RGB(255, 0, 0)
    Circle (xB, yB), 4, _RGB(255, 0, 0)

    Line (xA, yA)-(xO, yO), _RGB(0, 255, 128) ' Raggio al centro per A
    Line (xB, yB)-(xO, yO), _RGB(0, 255, 128) ' Raggio al centro per B

    Locate 3, 1: Print Using "Diametro angolare: ###.##### gradi"; 2 * theta * 180 / _Pi

    Print "Premi un tasto per continuare o ESC per uscire";
    k$ = Input$(1)
    If k$ = Chr$(27) Then End
Loop

