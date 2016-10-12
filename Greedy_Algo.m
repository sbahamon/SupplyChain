pop_cost = xlsread('quikflix.xlsx', 2, 'F2:G151'); %Population and cost matrix 
[num,city,raw] = xlsread('quikflix.xlsx', 2, 'B2:B151'); %city names vector
dist = xlsread('quikflix.xlsx', 3); %distance matrix
clear num
clear raw
%cleaning distance matrix
dist(1, :) = [];
dist(:, 1) = [];

rank_cov = [];

%rank coverage payoff
for r = 1:size(dist,1)
    for c = 1:size(dist,2)
        if dist(r,c) <= 150
            rank_cov(r,1) = pop_cost(r,2) / sum(dist(r,c)*pop_cost(r,1));
        end
    rank_cov(r,2) = r;
    end
end

clear r
clear c

%sorting rank coverage by size
rank_cov = sortrows(rank_cov);

%initializing inforomation about population
t_pop = sum(pop_cost,1);
t_pop = t_pop(:,1);
n_pop = 0.9*t_pop;
c_pop = 0;
cit_used = [];
clear t_pop

%finding cities used and adding to find population covered   
for i = 1:115
        c_pop = c_pop + pop_cost(rank_cov(i,2),1);
        cit_used = [cit_used; rank_cov(i,2)];
end 

clear i
names_used = city(cit_used);
fprintf('%s, ',names_used{:})