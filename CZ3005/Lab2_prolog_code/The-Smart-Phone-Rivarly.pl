company(sumSum).
company(appy).
smartPhoneTech(galacticaS3).
developed(galacticaS3,sumSum).
boss(stevey).
competitor(sumSum,appy).
steal(stevey,galacticaS3).

business(Product):-smartPhoneTech(Product).
rival(Company):-(competitor(Company,appy);competitor(appy,Company)),company(Company).
unethical(X):-boss(X),steal(X,Prod),business(Prod),developed(Prod,Comp),rival(Comp).