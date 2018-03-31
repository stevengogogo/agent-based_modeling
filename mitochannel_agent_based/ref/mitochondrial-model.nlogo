;;...AGENT-BASED MODELLING OF MITOCHONDRIAL POPULATIONS: LINKING SUB-CELLULAR DYNAMICS TO CELLULAR HOMEOSTASIS

breed [nucs nuc]       ; nucleus
breed [circles circle] ; circle --> only for visualization
breed [mitos mito]     ; mitochondria 
breed [lysos lyso]     ; lysosomes

;;...defining variables...................................................................................

globals [
  cx                 ;; x coordinate of the cell
  cy                 ;; y coordinate of the cell
  dim_dom            ;; dimension of the domain
  diam_nuc           ;; diameter of the nucelus
  dt                 ;; temporal increment
  sec                ;; second
  minute             ;; minute 
  hour               ;; hour
  ds                 ;; spatial increment
  mito-step_far      ;; mitochondrial step
  mito-step_close    ;; mitochondrial step
  EN_stress_level    ;; energetic stress
  vel_far            ;; mitochondrial velocity
  vel_close          ;; mitochondrial velocity
  vel_far2           ;; mitochondrial velocity
  vel_close2         ;; mitochondrial velocity
  initial_tot_number ;; initial mitochondrial number
  MR_th              ;; MR threshold
  prob_fusIn         ;; probability of fusion
  prob_fisIn         ;; probability of fission
  prob_biogenesisIn  ;; probability of biogenesis
  prob_damIn         ;; probability of damage
  dam_th             ;; damage threshold
  totmass            ;; total mass of mitochondria
  critMass           ;; critical mass
  min_mito_mass      ;; min mitochondrial mass
  max_mito_mass      ;; max mitochondrial mass
  small              ;; mitochondria with size <= 1
  mid                ;; mitochondria with size in (1,2]
  big                ;; mitochondria with size > 2
  counter            ;; counter
  freq_fusionIn      ;; fusion frequency
  freq_fissionIn     ;; fission frequency
  freq_degIn         ;; degradation frequency
  freq_bioIn         ;; biogenesis frequency
  arrmito            ;; array of all mitochondria
  arrmitoDam         ;; array of all damaged mitochondria
  totmassGreen       ;; total mass of GFP labeled mitochondria
  totmassDam         ;; total mass of damaged mitochondria
  totmassLow         ;; total mass of low damaged mitochondria 
  totmassHigh        ;; total mass of high damaged mitochondria
]


;;...PROPERTIES...................................................................................

mitos-own [ damage_level MR_level dam ]



;;...general setup...................................................................................

to setup  
  
  clear-all
  
  set cx 25
  set cy 25
  set dim_dom 50
  set diam_nuc dim_dom / 3
  set sec 1
  set minute 60 * sec
  set hour 60 * minute
  set min_mito_mass 0.5
  set max_mito_mass 3 
  set counter 0
  set arrmito [ ]
  set arrmitoDam [ ]
  set totmassGreen 0
  set totmassDam 0
  set totmassLow 0
  set totmassHigh 0
  
  
  set dt sec  ; (1sec)
  set ds 1    ; 1 um per patch
  set mito-step_far ( (2 * 0.5) / ds * dt ) ;; 0.5 um/s
  set mito-step_close ( (2 * 0.22) / ds * dt ) ;; 0.22 um/s
  
;;...CELL...................................................................................

  create-circles 1
  [
    set shape "cell"
    set size dim_dom
    ifelse (transmission)
    [set color white]
    [set color black]
    set xcor cx
    set ycor cy 
  ]
  
  ;; NUCLEUS
  create-nucs 1
  [
    set shape "circle"
    set size diam_nuc
    set color 38.5
    set xcor cx
    set ycor cy
  ]
  create-nucs 1
  [
    set shape "cell"
    set size diam_nuc
    set color 3
    set xcor cx
    set ycor cy
  ]
  
  ;; BACKGROUND
  if ( not transmission ) [ ask patches [ set pcolor one-of [ white ] ] ]
  
  
  
  ;; MITOCHONDRIA
  while [ counter < tot_mitochondria_mass ]
  [
    let dim (random-float 1) * (max_mito_mass - min_mito_mass) + min_mito_mass
    
    create-mitos 1
    [ 
      set size dim
      ifelse( size >= 2 )
      [set shape "mito2"] 
      [set shape "mitochondria"]
      
      set color blue
      set dam false
      
      let angle random-float 360
      
      let xx diam_nuc / 2 + dim / 2 + random-float (dim_dom / 2 - dim - diam_nuc / 2)
      
      set xcor cx + cos(angle) * xx
      set ycor cy + sin(angle) * xx
    ]
    set counter counter + dim
  ]
  
  ask mitos with [ dam = false ] [ set arrmito lput self arrmito ] 
  foreach arrmito
  [
    set totmass totmass + [size] of ? / tot_mitochondria_mass
    if ( [size] of ? <= 1 ) [ set small small + [size] of ? / tot_mitochondria_mass ]
    if ( [size] of ? > 1 and [size] of ? <= 2 ) [ set mid mid + [size] of ? / tot_mitochondria_mass ]
    if ( [size] of ? > 2 and [size] of ? <= max_mito_mass ) [ set big big + [size] of ? / tot_mitochondria_mass ]
  ]
  
  ;; TRANSMISSION
  if( transmission )
    [
      while [ totmassGreen < tot_mitochondria_mass * mito_green / 100 ] 
        [
          set totmassGreen 0
          ask one-of mitos with [color = blue]
          [ 
            if ( xcor <= max-pxcor / 2 and ycor <= max-pycor / 2 )
            [ 
              set color green
              let totmassGreenTemp [size] of mitos with [color = green]
              foreach totmassGreenTemp [ set totmassGreen totmassGreen + ? ]
            ]
          ]
        ]
      set totmassGreen totmassGreen / tot_mitochondria_mass
    ]
  
  
  ;; LOW DAMAGE
  if ( mitochondria_low_damage > 0 )
  [  
    while [ totmassLow < tot_mitochondria_mass * mitochondria_low_damage / 100 ] 
      [
        set totmassLow 0
        if ( any? mitos with [color = blue] )
          [
            ask one-of mitos with [color = blue]
            [ 
              set dam true
              set Damage_level 0
              set color brown
              let totmassLowTemp [size] of mitos with [color = brown]
              foreach totmassLowTemp [ set totmassLow totmassLow + ? ]
            ]
          ]
      ]
    set totmassLow totmassLow / tot_mitochondria_mass
  ]
  
  ;; HIGH DAMAGE
  if ( mitochondria_high_damage > 0 )
  [  
    while [ totmassHigh < tot_mitochondria_mass * mitochondria_high_damage / 100 and any? mitos with [color = blue] ] 
      [
        set totmassHigh 0
        ask one-of mitos with [color = blue]
          [ 
            set dam true
            set MR_level 0
            set color black
            let totmassHighTemp [size] of mitos with [color = black]
            foreach totmassHighTemp [ set totmassHigh totmassHigh + ? ]
          ]
      ]
    set totmassHigh totmassHigh / tot_mitochondria_mass
  ]
  
  ask mitos with [ dam = true ] [ set arrmitoDam lput self arrmitoDam ] 
  foreach arrmitoDam [ set totmassDam totmassDam + [size] of ? / tot_mitochondria_mass ] 
  
  
  set EN_stress_level 0
  
  set critMass 1 ; tot_mitochondria_mass
  
  reset-ticks
  
end

;;...running processes...................................................................................

to go
  
  
  
  
  set freq_fusionIn freq_fusion * minute
  set freq_fissionIn freq_fission * minute
  set freq_degIn freq_deg * minute
  set freq_bioIn freq_bio * minute
  set MR_th MR_threshold * minute
  set dam_th damage_threshold * minute  
  
  
  if( damage_signal_10-20 )
  [
    if ( ticks > 0 and ticks < 2 * hour ) [ set prob_damIn 0 ]
    if ( ticks >= 2 * hour and ticks < 2 * hour + 10 * minute ) [ set prob_damIn 10 ]
    if ( ticks >= 2 * hour + 60 * minute and ticks < 4 * hour ) [ set prob_damIn 0 ]
    if ( ticks >= 4 * hour and ticks < 4 * hour + 10 * minute ) [ set prob_damIn 20 ]
    if ( ticks >= 4 * hour + 60 * minute and ticks < 6 * hour) [ set prob_damIn 0 ]
    if ( ticks >= 6 * hour and ticks < 6 * hour + 10 * minute ) [ set prob_damIn 10 ]
    if ( ticks >= 6 * hour + 60 * minute and ticks < 8 * hour) [ set prob_damIn 0 ]
    if ( ticks >= 8 * hour and ticks < 8 * hour + 10 * minute ) [ set prob_damIn 20 ]
    if ( ticks >= 8 * hour + 60 * minute and ticks < 10 * hour) [ set prob_damIn 0 ]
    if ( ticks >= 10 * hour and ticks < 10 * hour + 10 * minute ) [ set prob_damIn 10 ]
    if ( ticks >= 10 * hour + 60 * minute ) [ set prob_damIn 0 ]
  ]
  
  if( damage_signal_40 )
  [
    if ( ticks > 0 and ticks < 2 * hour ) [ set prob_damIn 0 ]
    if ( ticks >= 2 * hour and ticks < 2 * hour + 60 * minute ) [ set prob_damIn 40 ]
    if ( ticks >= 2 * hour + 60 * minute and ticks < 4 * hour ) [ set prob_damIn 0 ]
    if ( ticks >= 4 * hour and ticks < 4 * hour + 60 * minute ) [ set prob_damIn 40 ]
    if ( ticks >= 4 * hour + 60 * minute and ticks < 6 * hour) [ set prob_damIn 0 ]
    if ( ticks >= 6 * hour and ticks < 6 * hour + 60 * minute ) [ set prob_damIn 40 ]
    if ( ticks >= 6 * hour + 60 * minute and ticks < 8 * hour) [ set prob_damIn 0 ]
    if ( ticks >= 8 * hour and ticks < 8 * hour + 60 * minute ) [ set prob_damIn 40 ]
    if ( ticks >= 8 * hour + 60 * minute and ticks < 10 * hour) [ set prob_damIn 0 ] 
    if ( ticks >= 10 * hour and ticks < 10 * hour + 60 * minute ) [ set prob_damIn 40 ]
    if ( ticks >= 10 * hour + 60 * minute ) [ set prob_damIn 0 ]
  ]
  
  if( not damage_signal_40 and not damage_signal_10-20 ) [ set prob_damIn prob_damage ]
  
  ;; SETTING FUSION/FISSION RATE ACCORDING TO STRESS AND STARVATION
  
  if ( not cell_EN_stress ) [ set EN_stress_level 0 ]
  ;; FUSION
  ifelse ( EN_stress_level > 0 )
  [
    set prob_fusIn ( prob_fusion * ( 1 + EN_stress_level ) ) 
    set prob_fisIn ( prob_fission * ( 1 - EN_stress_level ) )
  ]
  [
    set prob_fusIn prob_fusion
    set prob_fisIn prob_fission
  ]
  if ( prob_fusIn > 100 ) [ set prob_fusIn 100 ]
  if ( prob_fusIn < 0 ) [ set prob_fusIn 0 ]
  if ( prob_fisIn > 100 ) [ set prob_fisIn 100 ]
  if ( prob_fisIn < 0 ) [ set prob_fisIn 0 ]
  
  ;; BIOGENESIS
  ifelse ( cell_EN_stress )
  [
    ifelse ( EN_stress_level > 0 or totmass < critMass )
    [set prob_biogenesisIn ( 22.1 *  EN_stress_level * 100 )]
    [set prob_biogenesisIn prob_biogenesis]
    if ( prob_biogenesisIn > 100 ) [ set prob_biogenesisIn 100 ]
    if ( prob_biogenesisIn < 0 ) [ set prob_biogenesisIn 0 ]
  ]
  [ 
    set prob_biogenesisIn prob_biogenesis
  ]
  
  ;; MITOCHONDRIA

  
  if ( ticks mod 10 = 0 )
  [
    set vel_far random-float mito-step_far
    set vel_close random-float mito-step_close
    set vel_far2 random-float mito-step_far
    set vel_close2 random-float mito-step_close
  ]
  
  ask mitos
    [
      let NM random count mitos
      
      ifelse ( who < NM )
      [
        ifelse ( (xcor - cx) ^ 2 + (ycor - cy) ^ 2 < ((dim_dom / 2) / 2) ^ 2 )
        [ move_in_circle cx cy dim_dom diam_nuc vel_close size ]
        [ move_in_circle cx cy dim_dom diam_nuc vel_far size ]
      ]
      [
        ifelse ( (xcor - cx) ^ 2 + (ycor - cy) ^ 2 < ((dim_dom / 2) / 2) ^ 2 )
        [ move_in_circle cx cy dim_dom diam_nuc vel_close2 size ]
        [ move_in_circle cx cy dim_dom diam_nuc vel_far2 size ]
      ]
      
      turn
    ]
  
  ask lysos
    [
      move_in_circle cx cy dim_dom diam_nuc mito-step_close size 
      turn_nodir
    ]
  
  
  
  
  
  
  
  ;; FUSION 
  if ( freq_fusionIn != 0 and ticks mod (freq_fusionIn) = 0 and ticks > 0 )
  [
    
    set arrmito [ ]
    ask mitos with [ dam = false ] [ set arrmito lput self arrmito ]
    
    foreach arrmito
      [
        let r random-float 100
        if ( r < prob_fusIn )
          [
            ask ?
            [ 
              let closest min-one-of other mitos [distance myself]
              
              if ( closest != nobody and [color] of closest != black )
              [ 
                ifelse ( color = green )
                [
                  if (distance closest <= 1 + size / 2 + [size] of closest / 2)
                  [
                    if ( [color] of closest != 106 and size + [size] of closest <= max_mito_mass )
                    [
                      ask closest [set color 106]
                      set size size + [size] of closest
                      ifelse( size >= 2 )
                      [set shape "mito2"]
                      [set shape "mitochondria"]
                    ]
                  ]
                ]
                [
                  if (color = blue and distance closest <= 1 + size / 2 + [size] of closest / 2)
                  [
                    if ( [color] of closest = blue and size + [size] of closest <= max_mito_mass )
                    [
                      ask closest [set color 106]
                      set size size + [size] of closest
                      ifelse( size >= 2 )
                      [set shape "mito2"]
                      [set shape "mitochondria"]
                    ]
                    if ( [color] of closest = green and size + [size] of closest <= max_mito_mass )
                    [
                      ask closest [set color 106]
                      set size size + [size] of closest
                      set color green
                      ifelse( size >= 2 )
                      [set shape "mito2"]
                      [set shape "mitochondria"]
                    ]
                    if ( [color] of closest = brown and size + [size] of closest <= max_mito_mass and recovery )
                    [
                      ask closest [set color 106]
                      set size size + [size] of closest
                      ifelse( size >= 2 )
                      [set shape "mito2"]
                      [set shape "mitochondria"]
                    ]
                  ]
                  if (color = brown and distance closest <= 1 + size / 2 + [size] of closest / 2 and recovery )
                  [
                    if ( [color] of closest = blue and size + [size] of closest <= max_mito_mass )
                    [
                      ask closest [set color 106]
                      set size size + [size] of closest
                      set color blue
                      ifelse( size >= 2 )
                      [set shape "mito2"]
                      [set shape "mitochondria"]
                    ]
                  ]
                ]
              ]
            ]
          ]
      ]
    ask mitos with [color = 106] [die]
  ]
  
  
  ;; FISSION
  if ( freq_fissionIn != 0 and ticks mod (freq_fissionIn) = 0 and ticks > 0 )
  [
    set arrmito [ ]
    ask mitos with [ dam = false ] [ set arrmito lput self arrmito ]
    
    foreach arrmito
      [
        let r random-float 100
        if ( r < prob_fisIn )
          [
            ask ? 
            [
              if ( size >= 2 * min_mito_mass and dam = false )
              [
                let A  ( (random-float 1) * (0.5 - min_mito_mass / size) + min_mito_mass / size ) * size
                let B  (size - A)
                
                set size A 
                ifelse( size >= 2 )
                [set shape "mito2"]
                [set shape "mitochondria"]
                
                hatch-mitos 1
                [
                  let RR random-float 100
                  ifelse ( RR < prob_damIn )
                  [
                    let LH random-float 100
                    ifelse ( LH < ratio_lowHigh_damage )
                    [
                      set dam true
                      set MR_level 0
                      set color black 
                    ]
                    [
                      ifelse ( low_damage )
                      [
                        set dam true
                        set Damage_level 0
                        set color brown 
                      ]
                      [
                        set dam true
                        set MR_level 0
                        set color black 
                      ]
                      
                    ]
                  ]
                  [
                    set dam false
                  ]
                  
                  set size B 
                  ifelse( size >= 2 )
                  [set shape "mito2"]
                  [set shape "mitochondria"]
                ]
              ]
            ]
          ]
      ]
  ]
  
  
  
  
  ;; BIOGENESIS
  if ( freq_bioIn != 0 and ticks mod(freq_bioIn) = 0 and ticks > 0 )
    [
      
      set arrmito [ ]
      ask mitos with [ dam = false ] [ set arrmito lput self arrmito ]
      
      foreach arrmito
        [
          let r random-float 100
          if ( r < prob_biogenesisIn )
          [
            ask ? 
            [
              let increm random-float (size * 50 / 100)
              let sizeTemp size + increm
              
              if ( sizeTemp <= max_mito_mass )
              [
                set size sizeTemp 
                ifelse( size >= 2 )
                [set shape "mito2"]
                [set shape "mitochondria"]
              ]
            ]
          ]
        ]
    ]
  
  ;; LYSOSOMAL PRODUCTION
  if ( any? mitos with [color = black and shape = "autophag2"] )
  [
    let newlyso (count mitos with [color = black and shape = "autophag2"] - count lysos)
    if ( newlyso > 0 )
    [
      create-lysos newlyso
      [
        set shape "lyso"
        set size 1
        set color yellow
        
        let angle random-float 360
        
        let xx diam_nuc / 2 + 1 / 2 + random-float (dim_dom / 2 - 1 - diam_nuc / 2)
        
        set xcor cx + cos(angle) * xx
        set ycor cy + sin(angle) * xx
      ]
    ]
  ]
  
  
  ;; DEGRADATION
  if ( freq_degIn != 0 and ticks mod (freq_degIn) = 0 and ticks > 0 )
  [
    if ( any? mitos with [color = brown] )
    [
      ask mitos with [ color = brown ] 
        [  
          if ( Damage_level >= dam_th )
            [
              set MR_level 0
              set color black
            ]
        ]
    ]
    
    if ( any? mitos with [color = black] )
    [
      ask mitos with [ color = black ] 
        [
          if ( MR_level >= MR_th and shape = "mitochondria" or shape = "mito2" )
            [
              set shape "autophag"               
              set MR_level 0
            ]
          if ( MR_level >= MR_th and shape = "autophag" )
          [
            set shape "autophag2"
            set MR_level 0
          ]
        ]
    ] 
    
    if ( any? mitos with [shape = "autophag2"] )
    [
      ask lysos
        [
          if ( any? other mitos with [shape = "autophag2"] )
            [              
              facexy [xcor] of one-of other mitos with [shape = "autophag2"] [ycor] of one-of other mitos with [shape = "autophag2"]
            ]
        ]
      ask mitos 
        [ 
          if ( shape = "autophag2" and MR_level >= MR_th and any? other lysos in-radius 1 )
            [
              ask one-of other lysos in-radius 1
              [ die ]
              
              die
            ]
        ] 
    ]
  ]
  
  
  
  
  ;; INCREMENTS
  
  if ( cell_EN_stress )
  [
    ifelse ( totmass < critMass )
    [ set EN_stress_level abs(totmass - critMass) / ( critMass ) ]
    [ set EN_stress_level 0 ]
    
    if ( EN_stress_level >= 1 ) [ set EN_stress_level 1 ]
    if ( EN_stress_level <= 0 ) [ set EN_stress_level 0 ]
  ]
  
  ask mitos [ set damage_level damage_level + 1 ]
  ask mitos [ set MR_level MR_level + 1 ] 
  
  
  
  
  
  set arrmito [ ]
  set arrmitoDam [ ]
  set totmass 0
  set small 0
  set mid 0
  set big 0
  set totmassGreen 0
  set totmassDam 0
  
  ask mitos with [ dam = false ] [ set arrmito lput self arrmito ] 
  foreach arrmito
  [
    set totmass totmass + [size] of ? / tot_mitochondria_mass
    if ( [size] of ? <= 1 ) [ set small small + [size] of ? / tot_mitochondria_mass ]
    if ( [size] of ? > 1 and [size] of ? <= 2 ) [ set mid mid + [size] of ? / tot_mitochondria_mass ] 
    if ( [size] of ? > 2 and [size] of ? <= max_mito_mass ) [ set big big + [size] of ? / tot_mitochondria_mass ]
    if ( [color] of ? = green ) [ set totmassGreen totmassGreen + [size] of ? / tot_mitochondria_mass ]
  ]
  
  ask mitos with [ dam = true ] [ set arrmitoDam lput self arrmitoDam ] 
  foreach arrmitoDam [ set totmassDam totmassDam + [size] of ? / tot_mitochondria_mass ] 
  
  tick-advance dt
  update-plots
  

  
end


to go-many [number]
  repeat number [go]
end


;;==========================
;;        FUNCTIONS
;;==========================

;; movement inside circle
to move_in_circle [ xcIn ycIn diamIn diamnucIn mito-stepIn sizeIn ]
  if ( ([xcor] of self - xcIn) ^ 2 + ([ycor] of self - ycIn) ^ 2 <= (diamIn / 2 + [size] of self / 2) ^ 2 ) 
    [         
      ifelse ( not any? other turtles-on patch-ahead 1 )
        [ 
          forward mito-stepIn / sizeIn
          if ( ([xcor] of self - xcIn) ^ 2 + ([ycor] of self - ycIn) ^ 2 > (diamIn / 2 - [size] of self / 2) ^ 2 or ([xcor] of self - xcIn) ^ 2 + ([ycor] of self - ycIn) ^ 2 < ((diamnucIn) / 2 + [size] of self / 2) ^ 2 )
          [ 
            forward ( - mito-stepIn / sizeIn ) 
            rt 180
          ]
        ]
        [ rt random-float 90 ]
    ]
end

;; turn
to turn
  if ( not diretionality ) [rt random-float 360 - random-float 360]
end

to turn_nodir
  rt random-float 360 - random-float 360
end
@#$#@#$#@
GRAPHICS-WINDOW
10
10
785
806
-1
-1
15.0
1
10
1
1
1
0
1
1
1
0
50
0
50
0
0
1
Time (sec)
30.0

BUTTON
836
14
925
47
SETUP
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
838
60
928
93
GO
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
833
191
1059
224
tot_mitochondria_mass
tot_mitochondria_mass
0
500
300
1
1
NIL
HORIZONTAL

SLIDER
833
225
1064
258
mitochondria_low_damage
mitochondria_low_damage
0
100
0
10
1
%
HORIZONTAL

SLIDER
833
260
1064
293
mitochondria_high_damage
mitochondria_high_damage
0
100
0
10
1
%
HORIZONTAL

SLIDER
1422
227
1595
260
MR_threshold
MR_threshold
0
60
11
1
1
min
HORIZONTAL

PLOT
1445
466
1691
614
energy demand
seconds
stress
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"stress" 1.0 0 -2674135 true "" "plot EN_stress_level"

SLIDER
833
312
1005
345
prob_fusion
prob_fusion
0
100
50
5
1
%
HORIZONTAL

SLIDER
834
347
1006
380
prob_fission
prob_fission
0
100
50
5
1
%
HORIZONTAL

SLIDER
834
382
1006
415
prob_damage
prob_damage
0
100
0
5
1
%
HORIZONTAL

SWITCH
1280
386
1413
419
low_damage
low_damage
0
1
-1000

SLIDER
835
418
1007
451
prob_biogenesis
prob_biogenesis
0
100
0
1
1
%
HORIZONTAL

PLOT
1140
465
1437
615
mitochondria
seconds
mass
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"large mass" 1.0 0 -10899396 true "" "plot big"
"small mass" 1.0 0 -955883 true "" "plot small"
"totmass" 1.0 0 -7500403 true "" "plot totmass"
"middle mass" 1.0 0 -13345367 true "" "plot mid"
"damaged" 1.0 0 -16777216 true "" "plot totmassDam"

SLIDER
1280
423
1485
456
ratio_lowHigh_damage
ratio_lowHigh_damage
0
100
50
5
1
%
HORIZONTAL

SLIDER
1423
262
1599
295
damage_threshold
damage_threshold
0
60
10
1
1
min
HORIZONTAL

PLOT
834
465
1131
615
fusion/fission/damaging
seconds
probability
0.0
10.0
0.0
100.0
true
true
"" ""
PENS
"fusion" 1.0 0 -15973838 true "" "plot prob_fusIn"
"fission" 1.0 0 -12345184 true "" "plot prob_fisIn"
"biogenesis" 1.0 0 -817084 true "" "plot prob_biogenesisIn"
"damage signal" 1.0 0 -16777216 true "" "plot prob_damIn"

SWITCH
1080
192
1226
225
cell_EN_stress
cell_EN_stress
1
1
-1000

SWITCH
835
660
973
693
transmission
transmission
1
1
-1000

PLOT
1028
655
1328
805
transmission dynamics
seconds
mass
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"normal" 1.0 0 -13345367 true "" "plot ( totmass - totmassGreen )"
"labeled" 1.0 0 -10899396 true "" "plot ( totmassGreen )"

SLIDER
835
696
1007
729
mito_green
mito_green
0
100
0
10
1
%
HORIZONTAL

BUTTON
838
102
905
135
go 1h
go-many 3600
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
914
103
978
136
go 12h
go-many 12 * 3600
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
986
103
1050
136
go 24h
go-many 24 * 3600
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
1500
386
1695
419
damage_signal_10-20
damage_signal_10-20
1
1
-1000

SWITCH
1501
423
1696
456
damage_signal_40
damage_signal_40
0
1
-1000

SWITCH
834
148
969
181
diretionality
diretionality
1
1
-1000

SLIDER
1041
314
1213
347
freq_fusion
freq_fusion
0
60
5
1
1
min
HORIZONTAL

SLIDER
1041
351
1213
384
freq_fission
freq_fission
0
60
5
1
1
min
HORIZONTAL

SLIDER
1042
389
1214
422
freq_deg
freq_deg
1
60
6
1
1
min
HORIZONTAL

SLIDER
1042
426
1214
459
freq_bio
freq_bio
1
60
29
1
1
min
HORIZONTAL

SWITCH
1292
339
1403
372
recovery
recovery
0
1
-1000

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

autophag
true
0
Polygon -7500403 true true 30 240 15 210 0 150 15 90 30 60 60 30 90 15 135 0 165 0 210 15 240 30 270 60 285 90 300 150 285 210 270 240 240 240 255 210 270 150 255 90 240 60 180 15 120 15 60 60 45 90 30 150 45 210 60 240 30 240
Circle -7500403 false true 90 90 120
Polygon -7500403 false true 135 105 120 105 120 120 135 120 135 150 105 135 105 150 135 165 135 180 135 195 150 195 150 180 180 180 180 165 165 165 165 150 195 150 195 135 150 135 180 120 165 105 150 120 150 105 135 105

autophag2
true
0
Polygon -7500403 false true 135 105 120 105 120 120 135 120 135 150 105 135 105 150 135 165 135 180 135 195 150 195 150 180 180 180 180 165 165 165 165 150 195 150 195 135 150 135 180 120 165 105 150 120 150 105 135 105
Circle -7500403 false true 90 90 120
Circle -7500403 false true 16 16 268
Circle -7500403 false true 30 30 240

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

cell
true
0
Circle -7500403 false true -1 -1 301

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

drop
false
0
Circle -7500403 true true 73 15 152
Polygon -7500403 true true 219 119 205 148 185 180 174 205 163 236 156 263 149 293 147 134
Polygon -7500403 true true 79 118 95 148 115 180 126 205 137 236 144 263 150 294 154 135

ellips
true
0
Polygon -7500403 true true 15 180 15 120 60 60 120 45 180 45 240 60 285 120 285 180 240 240 180 255 120 255 60 240

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

lyso
false
0
Circle -7500403 true true 0 0 300
Circle -1 true false 60 60 180

mito2
true
0
Polygon -7500403 false true 165 300 135 300 105 270 90 210 90 75 105 30 135 0 165 0 195 30 210 75 210 210 195 270
Polygon -7500403 true true 150 285 150 240 120 255 105 240 150 225 150 210 105 210 105 195 150 195 150 180 90 180 90 165 150 165 150 135 105 135 105 120 150 120 150 105 120 105 120 90 150 90 150 75 105 60 120 45 150 60 150 15 165 15 165 60 180 30 195 45 165 75 210 75 210 90 165 90 165 105 195 105 195 120 165 120 165 150 210 150 210 165 165 165 165 180 210 180 210 195 165 195 165 210 195 210 195 225 165 225 195 255 180 270 165 240 165 285

mitochondria
true
0
Polygon -7500403 false true 180 285 120 285 60 240 45 180 45 120 60 60 120 15 180 15 240 60 255 120 255 180 240 240
Polygon -7500403 true true 135 270 135 240 105 255 90 240 135 225 135 210 75 210 75 195 135 195 135 180 60 180 60 165 135 165 135 135 60 135 60 120 135 120 135 105 75 105 75 90 135 90 135 75 90 60 105 45 135 60 135 30 150 30 150 60 165 60 180 30 195 45 165 75 225 75 225 90 165 90 165 105 240 105 240 120 165 120 165 150 240 150 240 165 165 165 165 180 225 180 225 195 165 195 165 210 210 210 210 225 165 225 195 255 180 270 165 240 150 240 150 270

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
