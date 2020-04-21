function transformed_rank_order = transform_mos(mos, ci)
% TRANSFORM_MOS Transform the MOS values given 95% Condifence Intervals, so
% two similar MOS values get a same rank although their MOS values are not
% equivalent.
% 
%%  MOS Transformation
% Tranform Mean Opinion Scores(MOS) values given the 95% Confidence 
% Intervals so that they can safely be used in the Rank based statistical 
% methods. As MOS values are calculated based on subjetive ratings, two
% eqivalent MOS values rearly observed in parctice even in test-re-test
% studies. As a result, dirrectly applying rank based statistcal techniques 
% including method Spearman's and  Kendall?s  rank  cor-relation, and 
% non-parametric  groups  comparison tests  (e.g.  Mann-Whitney  U  Test,  
% Wilcoxon  signed-rank  test,Kruskal-Wallis Test, Friedman Test) on MOS
% values might mislead the results.
% 
% @author: Babak Naderi, 17.01.2020
% See also: https://github.com/babaknaderi/MOS-transformation
%
% Cite: Naderi, Babak, and Moeller, Sebastian. "Transformation of Mean 
% Opinion Scores to AvoidMisleading of Ranked based Statistical Techniques",
% 2020 Twelfth International Workshop on Quality of Multimedia Experience 
% (QoMEX). IEEE, 2020.
%
% /*----------------------------------------------------------------------
% *  Licensed under the MIT License. See License.txt in the project root 
% *  for license information.
% *---------------------------------------------------------------------*/
%
    % sort the inputs to find the proper ranks
    [mos_sorted, mos_order] = sort(mos);
    ci_sorted = ci(mos_order);
    
    rank = zeros(size(mos_sorted));
    rank(1) = 1;
    
    % rank mos
    tied_set_mos =[];
    tied_set_ci = [];
    for i= 2:length(mos_sorted)        
        % check if it make a tied rank with the previous item
        if (isTiedRank(mos_sorted(i-1),ci_sorted(i-1), mos_sorted(i),ci_sorted(i)))
            %|| last_rank_upper_ci < round(mos_sorted(i),2))
            % make tied rank with previous one
            % now check if there is a set 
            if (isempty(tied_set_mos))
                % there is no set
                rank(i) = rank(i-1);
                tied_set_mos = [mos_sorted(i-1),mos_sorted(i)];
                tied_set_ci = [ci_sorted(i-1), ci_sorted(i)];
            else
                % there is a set
                % add the new item to the set
                rank(i) = rank(i-1);
                tied_set_mos =[tied_set_mos,mos_sorted(i)];
                tied_set_ci = [tied_set_ci, ci_sorted(i)];
                % check if the set is still valid
                if (~ isTiedSetValid(tied_set_mos,tied_set_ci))
                    %repaid the set
                    % add the last element of set to a new tmp set
                    tmp_mos = [tied_set_mos(end)];
                    tmp_ci = [tied_set_ci(end)];
                    rank(i) =  rank(i-1)+1;
                    tied_set_mos(end) =[];
                    tied_set_ci(end) =[];
                    %check if last element of set1 want to be in set2
                    while (length(tied_set_mos)>1 &&...
                           abs(tmp_mos(1)-tied_set_mos(end))< abs(tied_set_mos(end-1)-tied_set_mos(end)) &&...
                           isTiedSetValid([tied_set_mos(end),tmp_mos],[tied_set_ci(end), tmp_ci])...
                       )
                        tmp_mos = [tied_set_mos(end), tmp_mos];
                        tmp_ci = [tied_set_ci(end), tmp_ci];
                        tied_set_mos(end) =[];
                        tied_set_ci(end) =[];                
                    end
                    % now everyone in the tmp_mos should get rank(i)
                    for j=0:length(tmp_mos)-1
                        rank(i-j)= rank(i);
                    end
                    tied_set_mos =tmp_mos;
                    tied_set_ci = tmp_ci;
                end
                
                    
            end
            
         else
          % no tied rank
          rank(i) = rank(i-1)+1;
          tied_set_mos =[];
          tied_set_ci = []; 
         end
    end
    
           
    % set the rank in order of original input
    unsorted  = 1:length(mos_order);
    new_ind(mos_order) =  unsorted;
    transformed_rank_order= rank(new_ind);
end

function [is_tied] = isTiedRank(mos_a,ci_a,mos_b,ci_b)
    is_tied = false;
    if (round(mos_a,2) >= round(mos_b-ci_b,2) && round(mos_a,2) <= round(mos_b+ci_b,2))
        is_tied = true;
    end      
    if (round(mos_b,2) >= round(mos_a-ci_a,2) && round(mos_b,2) <= round(mos_a+ci_a,2))
        is_tied = true;
    end      
end

function [is_valid] = isTiedSetValid(mos_set,ci_set)
    is_valid = true;
    for i = [length(mos_set):-1:1]
        for j =  [i-1:-1:1]
            if (~isTiedRank(mos_set(i),ci_set(i),mos_set(j),ci_set(j)))
                is_valid = false;
                return;
            end
        end
    end
            
end