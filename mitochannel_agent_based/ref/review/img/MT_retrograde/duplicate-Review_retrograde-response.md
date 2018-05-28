# Review of retrograde model

__Title:__ [The yeast retrograde response as a model of intracellular signaling of mitochondrial dysfunction](https://www.frontiersin.org/articles/10.3389/fphys.2012.00139/full)

__Abstract__:
Mitochondrial dysfunction activates intracellular signaling pathways that impact yeast
longevity, and the best known of these pathways is the retrograde response. More recently,
similar responses have been discerned in other systems, from invertebrates to human cells.
However, the identity of the signal transducers is either unknown or apparently diverse,
contrasting with the well-established signaling module of the yeast retrograde response.
On the other hand, it has become equally clear that several other pathways and processes
interact with the retrograde response, embedding it in a network responsive to a variety
of cellular states. An examination of this network supports the notion that the master regulator
NFκB aggregated a variety of mitochondria-related cellular responses at some point
in evolution and has become the retrograde transcription factor. This has significant consequences
for how we view some of the deficits associated with aging, such as inflammation.
The support for NFκB as the retrograde response transcription factor is not only based on
functional analyses. It is bolstered by the fact that NFκB can regulate Myc–Max, which is
activated in human cells with dysfunctional mitochondria and impacts cellular metabolism.
Myc–Max is homologous to the yeast retrograde response transcription factor Rtg1–Rtg3.
Further research will be needed to disentangle the pro-aging from the anti-aging effects of
NFκB. Interestingly, this is also a challenge for the complete understanding of the yeast
retrograde response.

<img src='img/MT_retrograde/retrograde-pathway.jpg'>

# keynotes in retrograde response

## [The yeast retrograde response as a model of intracellular signaling of mitochondrial dysfunction](http://www.frontiersin.org/Integrative_Physiology/10.3389/fphys.2012.00139/abstract)

### Abstract

1. Mitochondrial dysfunction activates intracellular signaling pathways that impact yeast longevity.
    1. The best known one is the retrograde response
    2. It is also discerned in invertebrates to human cells
    3. NF$\kappa$B is a retrograde response transcription factor.
        1. discovered not only by functional analysis
        2. NF$\kappa$B can regulate Myc-Max, which is activated in human cells with dysfunctional mitochondria and impacts cellular metabolism
2. Myc-Max is homologus to the yeast retrograde response transcription factor Rtg1-Rtg3.

---

### Introduction

1. Mitochondrial dysfunction
    1. Mitochondrial encephalomyopathy
    2. cardiac hypertrophy
    3. Parkinson's disease
    4. cancer
    5. May determine life span
        1. *Caenorhabditis elegans*, *Drosophila melanogaster*, mouse, yeast
2. Identify retrograde response in [bioinformatics approach](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2980572/pdf/nihms233811.pdf)
3. Yeast retrograde response
    1. $\text{rho}^0$ vs. $\text{rho}^{+}$
        1. Lost TCA cycle $\rightarrow$ lost glutamate synthesis, due to compromised activity of succinate dehydrogenase
        2. Still poccess first three ractions
            1. Metabolic adaptation: $\alpha$-ketoglutarate $\rightarrow$ glumate. If citrate is provided by the activation of glyoxylate cycle
        3. No active electron transport chain
4. Retrograde response
    1. translocation of Rth1/3 heterodimer
        1. helix-loop-helix/leucine zipper proteins
        2. bind to the sequence GTCAC (R box)
        3. Rtg1 is atypical, there is no apparent transcriptional activation domains
        4. **Requires: Rtg2 protein**
            1. Rtg2 has no known homologs in higher organism
            2. Rtg2 promotes the dephosphorylation of Rtg3 by binding Mk1 and preventing Mk1 from forming a complex with the 14-4-4 protein Bmh1 or Bmh2 ([minor isoform](https://www.yeastgenome.org/locus/S000002506)), a complex which maintain in a hyperphosphorylated state.
            3. Mks1 is removed by ubiquitin-mediated degradation promoted by the ubiquitin ligase component Grr1.
                1. Grr1 $\rightarrow$ positive regulator
                2. Mks1 $\rightarrow$ Negative regulator
            4. TORC1 negatively regulate both upstream and downstream of Rtg2
                1. Genetic studies:
                    1. WD-protein Lst8/ mutation of Lst8
                2. When glutamate and nutrient are plentiful, TORC1 downregulates pathway
                3. TORC1 <-> negative feedback from dysfunctional mitochondria
                    1. mediate phosphorylation of Sch9 (AGC protein kinase) is downregulated
                    2. Phosorylated Sch9
                        1. Antagonize stress responses
                        2. 
            5. Reactions
                1. Rtg2 + Mks1 $\leftrightarrow$ Rtg2-Mks1
                1. Mks1 + Bmh  $\leftrightarrow$ Bmh-Mks1
                1. Bmh-Mks1 + *-Rtg3$^{hyper-p_{i}}$ $\leftrightarrow$ Bmh-Mks1-Rtg3$^{hyper-p_{i}}$ $\rightarrow$ Bmh-Mks1 + Rtg3$^{partial-p_{i}}$
                1. Mks1 + Grr1 $\leftrightarrow$ Mks1-Grr1 $\rightarrow$ Mks1$^{ubi}$ + Grr1
                1. Mks1$^{ubi}$ $\rightarrow$   

                where [*-Rtg3$^{hyper-p_{i}}$] = Rtg3$^{hyper-p_{i}}$ + Rtg1-Rtg3$^{hyper-p_{i}}$
    1. **only Rtg3 can bind to Rbox and activate transcription**
    2. Rtg1 is in the top layer. abundant, long-lived, and noisy.
    3. Osmotic stress can recruit Rtg1-Rtg3
    4. [Ras2](https://www.yeastgenome.org/locus/S000005042): unclear, relate to cAMP-dependent pathway. Positive regulator
        1. $\uparrow$ lifespan via cAMP-dependent pathway
    5. Rtg2 functions
        1. Positive regulator of retrograde response
            1. $\uparrow$ dephosphorylation of Rtg3 in cytoplasm
        2. Integral cofactor of transcriptional co-activator [SAGA-like complex](https://www.yeastgenome.org/go/GO:0046695), which is required for the induction of the retrograde response target gene CIT2, and it binds to CIT2 promoter
        3. Genome stability (unknown mechanism)
        4. **Sense dysfunctional mitochondria- possible mechanisms**
            1. $\downarrow$ of $\Delta \psi_{m}$ 
                1. When yeast ages, $\Delta \psi_m \downarrow$, loses mtDNA, progressive activation of retrograde response.
                2. Necessary and sufficient to induce retrograde response
                3. how Rtg2 read $\Delta \psi_{m}$: unclear
            2. ROS scavenger doesn't block signal
            3. ATP$\downarrow$ doesn't involve

Reagents|function
--------|--------
Rtg1-Rtg3|activate retrograde response
Rtg2|promote Rtg1-Rtg3: cytosol $\rightarrow$ nucleus; binding with Mks1
Mks1|phospholate Rtg3; downregulate RTG pathway
Bmh1 or Bmh2|form Bmh1/2-Mks1 to phosphate Rtg3
Grr1|degrade Mks1
TORC1|negative regulator of the retrograde response; act both upstream and downstream of Rtg2

# Review of retrograde signaling

__Title:__ [Mitochondria to Nuclear Signaling Is Regulated by the Subcellular Localization of the Transcription Factors Rtg1p and Rtg3p](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC14906/pdf/mk002103.pdf)

__Abstract__:
 Cells modulate the expression of nuclear genes in response to changes in the functional state of mitochondria, an interorganelle communication pathway called retrograde regulation. In yeast, expression of theCIT2 gene shows a typical retrograde response in that its expression is dramat-ically increased in cells with dysfunctional mitochondria, such as inro petites. Three genes control this  signaling  pathway:RTG1andRTG3 ,  which  encode  basic  helix-loop-helix  leucine  zipper transcription  factors  that  bind  as  heterodimer  to  theCIT2upstream  activation  site,  andRTG2 , which encodes a protein of unknown function. We show that in respiratory-competent (r1 ) cells in whichCIT2 expression is low, Rtg1p and Rtg3p exist as a complex largely in the cytoplasm, and inropetites in whichCIT2 expression is high, they exist as a complex predominantly localized in the  nucleus.  Cytoplasmic  Rtg3p  is  multiply  phosphorylated  and  becomes  partially  dephospho-rylated  when  localized  in  the  nucleus.  Rtg2p,  which  is  cytoplasmic  in  bothr1andro cells,  is required for the dephosphorylation and nuclear localization of Rtg3p. Interaction of Rtg3p with Rtg1p is required to retain Rtg3p in the cytoplasm ofr1 cells; in the absence of such interaction, nuclear localization and dephosphorylation of Rtg3p is independent of Rtg2p. Our data show that Rtg1p acts as both a positive and negative regulator of the retrograde response and that Rtg2p acts to transduce mitochondrial signals affecting the phosphorylation state and subcellular localization of Rtg3p
 
<img src='img/MT_retrograde/rtg-delete.png'>
<img src='img/MT_retrograde/translocate-hypo.png'>

# Review of transcription facor tanslocation 

__Title:__ [Tunable Signal Processing Through Modular Control of Transcription Factor Translocation](http://science.sciencemag.org/content/339/6118/460.long)

__Notes:__

* Functional Domains for translocation signaling
    * [Nucleus Export Sequence (NES)](https://en.wikipedia.org/wiki/Nuclear_export_signal)
    * [Nucleus Localization Sequence (NLS)](https://en.wikipedia.org/wiki/Nuclear_localization_sequence)

* Signal

Functional Domain|P-phosphorylated|U-unphosphorylated
---|---|---
NES|$\rightarrow$ Nucleus|$\rightarrow$ Cytosol
NLS|$\rightarrow$ Cytosol|$\rightarrow$ Nucleus

* Mathematical model of translocation

Because [there is only NLS site in RTG3](https://www.frontiersin.org/articles/10.3389/fphys.2012.00139/full), I only consider the case of _NLS only_ 

Ordinary differential equation:

$$\frac{dPr_{C}^{U}}{dt} = -(k_{in}^{'}+kp_{C})Pr_{C}^{U} + (k_{dp_C})Pr_{C}^{P} + (k_{out})Pr_{N}^{U} + 0 \times Pr_{N}^{P}$$

$$\frac{dPr_{C}^{P}}{dt} = (k_{p_C})Pr_{C}^{U} - (k_{in} + k_{dp_C})Pr_{C}^{P} + 0\times Pr_{N}^{U} +(k_{out})Pr_{N}^{P}$$

$$\frac{dPr_{N}^{U}}{dt} = (k_{in}^{'})Pr_{C}^{U}  + 0 \times Pr_{C}^{P} - (k_{p_N}+k_{out}) Pr_{N}^{U} + (k_{dp_N}) Pr_{N}^{P}$$

$$\frac{dPr_{N}^{P}}{dt} = 0\times Pr_{C}^{U} + (k_{in})Pr_{C}^{P} + (k_{p_N})Pr_{N}^{U} - (k_{out} + k_{dp_N})Pr_{N}^{P}$$

Matrix form:

\begin{equation*}
\frac{d}{dt} \begin{bmatrix} Pr_{C}^{U} \\ Pr_{C}^{P} \\ Pr_{N}^{U} \\ Pr_{N}^{P} \end{bmatrix}
=  \begin{bmatrix}
-(k_{in}^{'}+k_{p_C}) & k_{dp_C} & k_{out} & 0 \\
k_{p_C} &  -(k_{in} + k_{dp_C})  & 0 & k_{out} \\
k_{in}^{'}  & 0 & -(k_{p_N}+k_{out}) & k_{dp_N} \\
0 & k_{in} & k_{p_N} & -(k_{out} + k_{dp_N}) \\
\end{bmatrix}
\begin{bmatrix} Pr_{C}^{U} \\ Pr_{C}^{P} \\ Pr_{N}^{U} \\ Pr_{N}^{P} \end{bmatrix}
\end{equation*}


Notation|Content
---|---
P|Phosphorylated
U|Unphosphorylated
C|cytoplasmic
N|nuclear
$Pr^{\{U,P\}}_{\{C,N\}}$|Protein with NLS only
$k_{in}$|normal output rate for $Pr^{P}_{C}$
$k_{in}^{'}$| enchanced input rate for $Pr^{U}_{C}$
$k_{p_C}$| Cytoplasmic phosphorylation rate
$k_{p_N}$| Nucleus phosphorylation rate
$k_{dp_{C}}$| Cytoplasmic dephosphorylation rate
$k_{dp_{N}}$| Nucleus dephosphorylation rate
$k_{out}$|Export rate. Same value for NLS-only transcription factor

<img src='img/MT_retrograde/translocate1.png'>

# 4. RTG Network Analysis 
from [STRING](https://string-db.org/cgi/network.pl?taskId=bkkTcyhJN03C)

__Conslusion:__

1. Bottle nect effect in RTG-to-CIT2 pathway

<img src='img/MT_retrograde/rtg-net.png'>

# Review of Mitochondrial network scaling 

__Title:__ [Mitochondrial Network Size Scaling in Budding Yeast](http://science.sciencemag.org/content/338/6108/822)

__Abstract:__ Mitochondria must grow with the growing cell to ensure proper cellular physiology and inheritance upon division. We measured the physical size of mitochondrial networks in budding yeast and found that mitochondrial network size increased with increasing cell size and that this scaling relation occurred primarily in the bud. The mitochondria–to–cell size ratio continually decreased in aging mothers over successive generations. However, regardless of the mother’sage or mitochondrial content, all buds attained the same average ratio. Thus, yeast populations achieve a stable scaling relation between mitochondrial content and cell size despite asymmetry in inheritance.

__Conclusion:__

1. Yeast mitochondrial volume = [0.3, 4] $\mu m^{2}$

<img src='img/MT_retrograde/yeast_mito_volume.jpg'>
<img src='img/MT_retrograde/yeast_mito_volume2.png'>

# Ｍathematical Model of Retrograde Response

## __Biochemical Network component__:
    
1. Input $\vec{MT}$ with N species:
$$\vec{MT} := MT_1,...,MT_N$$
where N is the total number of mitochondria

1. Input coding:
 $$S = \sum_{i=1}^{N} Volume_{MT_i} \times Damaged_{MT_i}$$
 $$Volume_{MT_i} \propto size_in_2D$$ 
   Distributions of $Volume_{MT_i}$ and $Damaged_{MT_i}$ can be derived from [Mitochondrial-netlogo-model](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0168198) 
   
   1. $Volume_{MT_i} := \{0, V_{max}\}$
       
       $$V_{max} = \frac{4}{3}h \times Area_{MT_{i}}$$
       
       yeast mitochondria volime = [0.3, 4] $\mu m^{2}$
   
   1. $Damaged_{MT_i} := \{0, 1\}$ where 0 represents healthy state, and 1 represents damaged state of mitochondrion i ($MT_i$)
    
2. Channel $\nu$ with M species:
   
   1. Components:
   $$V_1,...,V_M$$where M is the total number of proteins involved in network
   
   1. Label (in input-to-output order):
       1. $V_{1}:=Rtg2_{C} ^{ina}$
       1. $V_{2}:=Rtg2_{C} ^{act}$ 
       1. $V_{3}:=Rtg3_C^{P}$
       1. $V_{4}:=Rtg3_C^{U}$
       1. $V_{5}:=Rtg3_N^{P}$
       1. $V_{6}:=Rtg3_N^{U}$
       1. $V_{7}:=Rtg1_C$
       1. $V_{8}:=Rtg1_N$
       1. $V_{9}:={Rtg1-3}_C^{P}$
       1. $V_{10}:={Rtg1-3}_C^{U}$
       1. $V_{11}:={Rtg1-3}_N^{P}$
       1. $V_{12}:={Rtg1-3}_N^{U}$
       1. $V_{13}:=Bmh_{C}$
       1. $V_{14}:= Bmh-Mks1_{C}$
       1. $V_{15}:= Mks1-Rtg2^{ina}_{C}$
       1. $V_{16}:= Mks1-Rtg2^{act}_{C}$
       
       __Note__: $Protein^{*}_{\#}$, the notations represent *:{modification state}; #:{Location}
  
   2. $Rtg1-3_{\#}^{*}$: hereodimer can activate CIT2 expression, then start retrograde response. 
       1. *: {p, u} (phosphtate, partially dephosphated)
       1. #: {n,c} {nucleus, cytoplasm}
   
   3. [$Rtg2^{*}$](https://www.yeastgenome.org/locus/S000003221): 
       1. a sensor of mitochondrial dysfunction.
       1. *: {inactivated (ina), activated (a)}
   
   3. TORC1 effect is ignored, for it is nutrient-dependent 
   
   3. Ras2 is ignored and combined to the process of TORC1 inhibition

3. Output $X$ with 1 componemt:
   1. $X_{1}= {Rtg1/3}_{n}^{*}$
   2. $[{Rtg1/3}_{n}^{*}]=[{Rtg1/3}_{n}^{p}]+[{Rtg1/3}_{n}^{u}]$

## Reaction

The following displays all reactions mentioned in [review1](#Review-of-retrograde-model) and [review2](#Review-of-retrograde-signaling):

RTG2 

> $Rtg2_{C}^{ina} \rightarrow   Rtg2_{C}^{act}$ (Eq:1)

> $Rtg2_{C}^{act} \rightarrow Rtg2_{C}^{ina}$ (Eq:2)

RTG2, BMH AND MKS1

> $Rtg2_{C}^{ina} + Mks1_{c} \rightleftharpoons  Rtg2^{ina}-Mks1_{C}$ (Eq:3)

> $Rtg2_{C}^{act} + Mks1_{C} \rightleftharpoons  Rtg2^{act}-Mks1_{C}$ (Eq:4)

> $Mks1 + Bmh  \rightleftharpoons  Bmh-Mks1$ (Eq:5)

> $Bmh-Mks1_{C} + Rtg3_{C}^{U} \rightleftharpoons  Bmh-Mks1-Rtg3_{C}^{U} \rightarrow$ $Bmh-Mks1_{C} + Rtg3_{C}^{P}$ (Eq:6)

RTG3 

> $Rtg3_{C}^{U} \rightleftharpoons  Rtg3_{N}^{U}$ (Eq:7)

> $Rtg3_{C}^{P} \rightleftharpoons  Rtg3_{N}^{P}$ (Eq:8)

> $Rtg3_{N}^{P} \rightleftharpoons  Rtg3_{N}^{U}$ (Eq:9)

> $Rtg3_{C}^{P} \rightleftharpoons Rtg3_{C}^{U}$ (Eq:10)

RTG1 AND RTG3 

> $Rtg3_{C}^{U} + Rtg1_{C} \rightleftharpoons  Rtg1/3_{C}^{U}$ (Eq:11)

> $Rtg3_{C}^{P} + Rtg1_{C} \rightleftharpoons  Rtg1/3_{C}^{P}$ (Eq:12)

> $Rtg3_{N}^{U} + Rtg1_{N} \rightleftharpoons  Rtg1/3_{N}^{U}$ (Eq:13)

> $Rtg3_{N}^{P} + Rtg1_{N} \rightleftharpoons  Rtg1/3_{N}^{P}$ (Eq:14)

RTG1/3 

> $Rtg1/3_{C}^{U} \rightleftharpoons  Rtg1/3_{N}^{U}$ (Eq:15)

> $Rtg1/3_{C}^{P} \rightleftharpoons  Rtg1/3_{N}^{P}$ (Eq:16)




## Differential Equation-based Framework

$$\frac{d}{dt}V_{1} := \frac{d}{dt}[Rtg2_{C}^{ina}] = - k_1 [Rtg2_{C}^{ina}] + kn_1 [Rtg2^{act}_{C}] - k_2[Rtg2_{C}^{ina}][Mks1_{C}] + kn_2[Rtg2^{ina}-Mks1_{C}]$$

$$\frac{d}{dt}V_{2} := \frac{d}{dt}[Rtg2_{C}^{act}] = - k_3[Rtg_{C}^{act}][Mks1_{C}] + kn_3 [Rtg_{2}^{ina}-Mks1_{C}]$$

$$\frac{d}{dt}V_3 := \frac{d}{dt}[Rtg3^{P}_{C}] = [Bmh-Mks1_{C}]\frac{[Rtg3^{U}_{C}]^{n_5}}{k_5 + [Rtg3^{U}_{C}]^{n5}}-k_9[Rtg3_{C}^{P}][Rtg1_{C}]+kn_9[Rtg1/3^{P}_{C}]$$

$$\frac{d}{dt}V_{4}:=\frac{d}{dt}[Rtg3_C^{U}]$$
$$\frac{d}{dt}V_{5}:=\frac{d}{dt}[Rtg3_N^{P}]$$
$$\frac{d}{dt}V_{6}:=\frac{d}{dt}[Rtg3_N^{U}]$$
$$\frac{d}{dt}V_{7}:=\frac{d}{dt}[Rtg1_C]$$
$$\frac{d}{dt}V_{8}:=\frac{d}{dt}[Rtg1_N]$$
$$\frac{d}{dt}V_{9}:=\frac{d}{dt}[{Rtg1-3}_C^{P}]$$
$$\frac{d}{dt}V_{10}:=\frac{d}{dt}[{Rtg1-3}_C^{U}]$$
$$\frac{d}{dt}V_{11}:=\frac{d}{dt}[{Rtg1-3}_N^{P}]$$
$$\frac{d}{dt}V_{12}:=\frac{d}{dt}[{Rtg1-3}_N^{U}]$$
$$\frac{d}{dt}V_{13}:=\frac{d}{dt}[Bmh_{C}]$$
$$\frac{d}{dt}V_{14}:= \frac{d}{dt}[Bmh-Mks1_{C}]$$
$$\frac{d}{dt}V_{15}:= \frac{d}{dt}[Mks1-Rtg2^{ina}_{C}]$$
$$\frac{d}{dt}V_{16}:= \frac{d}{dt}[Mks1-Rtg2^{act}_{C}]$$

## Necessary requirements:

From [review2](#Review-of-retrograde-signaling), GFP experiments describes 14 localizton patterns by deletions of Rtg1, Rtg2, and Rtg3. The derived mathematical model has to fulltill all of the requirements that found in real world.



1. Properties of Rtg3p-GFP localization 

Property|$[*-Rtg1_{*}]$| $[Rtg2_{C}]$ | S 
----------|--------|---------|---
$[*-Rtg3^{*}_{C}] > [*-Rtg3^{*}_{N}]$| >0 | >0 | =0
$[*-Rtg3^{*}_{C}] > [*-Rtg3^{*}_{N}]$| >0 | =0 | =0
$[*-Rtg3^{*}_{C}] > [*-Rtg3^{*}_{N}]$| >0 | =0 | =high
$[*-Rtg3^{*}_{C}] < [*-Rtg3^{*}_{N}]$| >0 | >0 | =high
$[*-Rtg3^{*}_{C}] < [*-Rtg3^{*}_{N}]$| =0 | >0 | =0
$[*-Rtg3^{*}_{C}] < [*-Rtg3^{*}_{N}]$| =0 | >0 | =high
$[*-Rtg3^{*}_{C}] < [*-Rtg3^{*}_{N}]$| =0 | =0 | =0
$[*-Rtg3^{*}_{C}] < [*-Rtg3^{*}_{N}]$| =0 | =0 | =high

where 
$$[*-Rtg3^{*}_{C}]=[Rtg1-Rtg3^{P}_{C}] + [Rtg1-Rtg3^{U}_{C}] + [Rtg3^{U}_{C}] + [Rtg3^{P}_{C}]$$

$$[*-Rtg3^{*}_{N}]=[Rtg1-Rtg3^{P}_{N}] + [Rtg1-Rtg3^{U}_{N}] + [Rtg3^{U}_{N}] + [Rtg3^{P}_{N}]$$

$$[*-Rtg1_{*}] = [Rtg1_{C}] + [Rtg1_{N}] + [Rtg1-Rtg3^{P}_{C}] + [Rtg1-Rtg3^{U}_{C}] + [Rtg1-Rtg3^{P}_{N}] + [Rtg1-Rtg3^{U}_{N}]$$

2. Properties of Rtg1p-GFP localization

Properties|$[Rtg3^{*}_{\#}]$| $[Rtg2_{C}]$ | S 
----------|--------|---------|---
$[*-Rtg1_{C}]>[*-Rtg1_{N}]$|>0|>0|=0
$[*-Rtg1_{C}]>[*-Rtg1_{N}]$|>0|=0|=0
$[*-Rtg1_{C}]>[*-Rtg1_{N}]$|>0|=0|=high
$[*-Rtg1_{C}]>[*-Rtg1_{N}]$|=0|>0|=0
$[*-Rtg1_{C}]>[*-Rtg1_{N}]$|=0|>0|=high
$[*-Rtg1_{C}]<[*-Rtg1_{N}]$|>0|>0|=high

where

$$[*-Rtg1_{C}] = [Rtg1_{C}] + [Rtg1-Rtg3^{P}_{C}] + [Rtg1-Rtg3^{U}_{C}]$$

$$[*-Rtg1_{N}] = [Rtg1_{N}] + [Rtg1-Rtg3^{P}_{N}] + [Rtg1-Rtg3^{U}_{N}]$$

$$[Rtg3^{*}_{\#}] = [*-Rtg3^{*}_{C}] + [*-Rtg3^{*}_{N}]$$

## Truth Table and Karnaugh Map

In order to display these properties, I used boolean funtion to model input-output relation, and applied [Karnaugh map](https://en.wikipedia.org/wiki/Karnaugh_map) to find the simplest boolean formula of RTG pathway.


### 1. Rtg3p Translocation

__Definition__

Condition|Mapping to Boolean Space
---|---
$[*-Rtg3^{*}_{C}] < [*-Rtg3^{*}_{N}]$ | 1
$[*-Rtg3^{*}_{C}] > [*-Rtg3^{*}_{N}]$ | 0
$[*-Rtg1_{*}]>0$ | 1
$[*-Rtg1_{*}]=0$| 0
$[Rtg2_{C}]>0$ | 1
$[Rtg2_{C}]=0$ | 0
$S=high$|1
$S=0$|0

\begin{equation}
Translocation_{Rtg3} := \left\{\begin{matrix}
1 \text{ if } [*-Rtg3^{*}_{C}] < [*-Rtg3^{*}_{N}]\\ 
0 \text{ if }[*-Rtg3^{*}_{C}] > [*-Rtg3^{*}_{N}]
\end{matrix}\right.
\end{equation}

__Truth Table:__

$Bool([*-Rtg1_{*}])$ | $Bool([Rtg2_{C}])$ | S | $Translocation_{Rtg3}$ (Output)
---|---|---|---
0|0|0|x
0|0|1|1
0|1|0|1
0|1|1|1
1|0|0|0
1|0|1|0
1|1|0|0
1|1|1|1

__Result__:

$$Translocation_{Rtg3} = \sim Bool([*-Rtg1_{*}]) + Bool([Rtg2_{C}])\times S$$

This model expects (0,0,0,1)


### 2. Rtg1p Translocation

__Definition__
    
Condition|Mapping to Boolean Space
---|---
$[*-Rtg1_{C}]>[*-Rtg1_{N}]$|0
$[*-Rtg1_{C}]<[*-Rtg1_{N}]$|1
$[Rtg3^{*}_{\#}]>0$|1
$[Rtg3^{*}_{\#}]=0$|0
$[Rtg2_{C}]>0$|1 
$[Rtg2_{C}]=0$|0 
$S=high$|1
$S=0$|0

\begin{equation}
Translocation_{Rtg1} := \left\{\begin{matrix}
1 \text{ if } [*-Rtg1_{C}]<[*-Rtg1_{N}]\\ 
0 \text{ if }[*-Rtg1_{C}]>[*-Rtg1_{N}]
\end{matrix}\right
\end{equation}

__Truth table__

$Bool([Rtg3^{*}_{\#}])$ | $Bool([Rtg2_{C}])$ | S | $Translocation_{Rtg1}$ (Output)
---|---|---|---
0|0|0|x
0|0|1|x
0|1|0|0
0|1|1|0
1|0|0|0
1|0|1|0
1|1|0|0
1|1|1|1


where x is "don't care term", for some relations aren't verified in [review2](#Review-of-retrograde-signaling)


__Result__:

$$Transduction_{Rtg1} = Bool([Rtg3^{*}_{\#}]) \times Bool([Rtg2_{C}]) \times S$$

This model expects (0,0,0,0), (0,0,1,0)

## Construct a channel 

$$x_1 = channel(\vec{MT}, \vec{V})$$

where $x_1 := Rtg1/3_{N}^{*} = Rtg1/3_{N}^{U}+ Rtg1/3_{N}^{P}$ 

Define 
$$Hill_act(s_{i})=\frac{}{}$$

__Question: How to achieve maximum information transmission under known $\vec{MT}$__:

The model $$[MT_1, MT_2,...,MT_N]->S_1->\nu->X_1$$ In order to decode $X_1$, the ouput needs to one-to-one mapping to all possibilities of input array, that is, $\vec{MT}$, there are $2^{N}$ possible combination. 

## Frequency Response

__Lemma__:

A system can be linearized by the following equations:

$$\frac{d}{dt}\textbf{x} = f(\textbf{x}(t),\textbf{u}(t)) = \textbf{A}x(t) + \textbf{B}u(t) $$

$$y(t) = h(\textbf{x}(t),\textbf{u}(t)) = \textbf{C}x(t) + \textbf{D}u(t)$$

where 

Symbol|Content|Property
---|---|---
$\textbf{x}$|System state|Vector
$\textbf{u}$|Input|Vector
y|output|value
$\textbf{A}$|System Jacobian|Matrix
$\textbf{B}$|Input maps|Matrix
$\textbf{C}$|Output Maps|Matrix
$\textbf{D}$|Feed-forward term|Matrix

Then

$$H(\omega) = \textbf{C}(i\omega\textbf{I}-\textbf{A})^{-1}\textbf{B} + D$$