#!/usr/bin/env bash

plink --file hapmap1 

plink --file hapmap1 --make-bed --out hapmap1 

plink --file hapmap1 --make-bed --mind 0.05 --out highgeno 

plink --bfile hapmap1 

plink --bfile hapmap1 --missing --out miss_stat 

#more miss_stat.lmiss 

plink --bfile hapmap1 --chr 1 --out res1 --missing 

plink --bfile hapmap1 --chr 2 --out res2 --missing 

plink --bfile hapmap1 --freq --out freq_stat 

plink --bfile hapmap1 --freq --within pop.phe --out freq_stat 

#more freq_stat.frq.strat 

plink --bfile hapmap1 --snp rs1891905 --freq --within pop.phe --out snp1_frq_stat 

plink --bfile hapmap1 --assoc --out as1 

sort --key=7 -nr as1.assoc | head 

plink --bfile hapmap1 --assoc --adjust --out as2 

#more as2.assoc.adjusted 

plink --bfile hapmap1 --pheno pop.phe --assoc --adjust --out as3 

plink --bfile hapmap1 --model --snp rs2222162 --out mod1

plink --bfile hapmap1 --model --cell 0 --snp rs2222162 --out mod2 

plink --bfile hapmap1 --cluster --mc 2 --ppc 0.05 --out str1 

#more str1.cluster1 

plink --bfile hapmap1 --mh --within str1.cluster2 --adjust --out aac1 

#more aac1.cmh.adjusted 

plink --bfile hapmap1 --cluster --cc --ppc 0.01 --out version2 

plink --bfile hapmap1 --mh --within version2.cluster2 --adjust --out aac2 

plink --bfile hapmap1 --cluster --K 2 --out version3 

plink --bfile hapmap1 --mh --within pop.phe --adjust --out aac3 

plink --bfile hapmap1 --cluster --matrix --out ibd_view 




plink --bfile hapmap1 --assoc --pheno qt.phe --out quant1 

plink --bfile hapmap1 --assoc --pheno qt.phe --perm --within str1.cluster2 --out quant2 
plink --bfile hapmap1 --assoc --pheno qt.phe --mperm 1000 --within str1.cluster2 --out quant3 

plink --bfile hapmap1 --pheno qt.phe --gxe --covar pop.phe --snp rs2222162 --out quant3

plink --bfile hapmap1 --snp rs2222162 --recodeAD --out rec_snp1 

R -e "rmarkdown::render('runPlink.Rmd', output_format='all')"








