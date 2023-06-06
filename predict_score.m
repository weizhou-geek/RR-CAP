%demo
clc
clear all
close all

tic

dis_pc = pcread('romanoillamp_20.ply');
dimage = getProjection(dis_pc);
dis_img1 = uint8(dimage{1});dis_img2 = uint8(dimage{2});
dis_img3 = uint8(dimage{3});dis_img4 = uint8(dimage{4});
dis_img5 = uint8(dimage{5});dis_img6 = uint8(dimage{6});

ref_pc = pcread('romanoillamp.ply');
rimage = getProjection(ref_pc);
ref_img1 = uint8(rimage{1});ref_img2 = uint8(rimage{2});
ref_img3 = uint8(rimage{3});ref_img4 = uint8(rimage{4});
ref_img5 = uint8(rimage{5});ref_img6 = uint8(rimage{6});

si=[];
q_sim=[];
q_hist=[];

%% 1
si1=abs(CalImgSI(dis_img1)-CalImgSI(ref_img1));
[q_sim1,q_hist1]=CalSaliency(ref_img1,dis_img1);
si = [si; si1];
q_sim = [q_sim; q_sim1];
q_hist = [q_hist; q_hist1];

%% 2
si2=abs(CalImgSI(dis_img2)-CalImgSI(ref_img2));
[q_sim2,q_hist2]=CalSaliency(ref_img2,dis_img2);
si = [si; si2];
q_sim = [q_sim; q_sim2];
q_hist = [q_hist; q_hist2];

%% 3
si3=abs(CalImgSI(dis_img3)-CalImgSI(ref_img3));
[q_sim3,q_hist3]=CalSaliency(ref_img3,dis_img3);
si = [si; si3];
q_sim = [q_sim; q_sim3];
q_hist = [q_hist; q_hist3];

%% 4
si4=abs(CalImgSI(dis_img4)-CalImgSI(ref_img4));
[q_sim4,q_hist4]=CalSaliency(ref_img4,dis_img4);
si = [si; si4];
q_sim = [q_sim; q_sim4];
q_hist = [q_hist; q_hist4];

%% 5
si5=abs(CalImgSI(dis_img5)-CalImgSI(ref_img5));
[q_sim5,q_hist5]=CalSaliency(ref_img5,dis_img5);
si = [si; si5];
q_sim = [q_sim; q_sim5];
q_hist = [q_hist; q_hist5];

%% 6
si6=abs(CalImgSI(dis_img6)-CalImgSI(ref_img6));
[q_sim6,q_hist6]=CalSaliency(ref_img6,dis_img6);
si = [si; si6];
q_sim = [q_sim; q_sim6];
q_hist = [q_hist; q_hist6];

quality = mean((q_sim.^(si))).*mean(q_hist)

num2str(toc)


