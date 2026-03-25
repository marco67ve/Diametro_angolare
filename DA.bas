' DA.BAS - Rappresentazione grafica del diametro angolare
' Marco da Venezia, 1988

SCREEN 12

Pi = 3.141592653589793#

DO
    CLS
    VIEW PRINT 1 TO 1
    INPUT "Raggio dell'oggetto"; r
    IF r <= 0 THEN r = 1
    PRINT "Raggio:"; r;
    VIEW PRINT 2 TO 2
    INPUT "Distanza dall'oggetto"; D
    IF D < r THEN D = r ' forza il diametro angolare massimo a 180ø
    PRINT "Distanza:"; D;
    VIEW PRINT
    IF 2 * r > D * 3 / 4 THEN scala = 2 * r / 400 ELSE scala = D / 600 ' adatta la scala alle dimensioni dello schermo
    r = r / scala
    D = D / scala
    
    ' Coordinate osservatore (Eye) e centro oggetto
    xE = 0: yE = 240
    xO = D: yO = 240

    ' Angolo tra EO e tangente (EA speculare EB) mezzo diametro angolare
    theta = ATN((r / D) / SQR(1 - (r / D) ^ 2))
   
    A = Pi / 2 - theta ' Angolo in alto a sinistra
    B = Pi / 2 + theta ' Angolo in basso a sinistra

    xA = xO - r * COS(A) ' segno '-' perch‚ il centro O Š a DESTRA di A
    yA = yO - r * SIN(A) ' segno '-' perch‚ O Š inferiore ad A nel sistema di coordinate dello schermo
    xB = xA
    yB = yO + r * SIN(B)

    LINE (0, 240)-(640, 240), 7 ' Asse orizzontale X
    LINE (xO, 0)-(xO, 480), 7   ' Asse verticale per O

    CIRCLE (xE, yE), 10, 10          ' pupilla/iride
    CIRCLE (xE, yE), 20, 10, , , 1.5 ' palpebre
    CIRCLE (xO, yO), r, 11           ' oggetto
   
    ' Tangenti dall'occhio ai punti A e B
    LINE (xE, yE)-(xA, yA), 4
    LINE (xE, yE)-(xB, yB), 4

    ' Segnapunti A e B sulla circonferenza
    CIRCLE (xA, yA), 2, 4
    CIRCLE (xB, yB), 2, 4

    LINE (xA, yA)-(xO, yO), 2 ' Raggio al centro per A
    LINE (xB, yB)-(xO, yO), 2 ' Raggio al centro per B

    LOCATE 29, 1
    PRINT USING "Diametro angolare: ###.##### gradi"; 2 * theta * 180 / Pi
    LOCATE 30, 1
    PRINT "Premi un tasto per continuare o ESC per uscire";
    k$ = INPUT$(1)
    IF k$ = CHR$(27) THEN END
LOOP

