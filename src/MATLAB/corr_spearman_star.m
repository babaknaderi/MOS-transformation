function [rho_star, pval]= corr_spearman_star(mos_a, ci_a, mos_b, ci_b)
% corr_spearman_star: Calculate spearman's rank correlation between two MOS
% distributions considering their 95% Confidence Interval in Rank
% Calculation.
% 
% The Spearman's rank correlation is not robus to minor changes and high
% precisions. In addition rank of two following values is determined by
% direct comparision which is not suitable for subjective test results, in
% which Mean Opinion Scores are calculated by averaging many votes and
% always followed by a 95% Confidence Interval.
% In this implementation, two following MOS values consider to be equally
% ranked when one of the is in the range of the other's MOS+/- 95%CI.
%
% @author: Babak Naderi, 17.01.2020
%
% See also: https://github.com/babaknaderi/Spearman-s-rank-correlation
% /*----------------------------------------------------------------------
% *  Licensed under the MIT License. See License.txt in the project root 
% *  for license information.
% *---------------------------------------------------------------------*/
%
    % sort the inputs to find the proper ranks
    [mos_a_sorted, mos_a_order] = sort(mos_a);
    ci_a_sorted = ci_a(mos_a_order);
    
    [mos_b_sorted, mos_b_order] = sort(mos_b);
    ci_b_sorted = ci_b(mos_b_order);
    
    rank_a = zeros(size(mos_a_sorted));
    rank_b = zeros(size(mos_b_sorted));
    rank_a(1) = 1;
    rank_b(1) = 1;
    
    % rank mos_a
    last_rank = 1;
    last_rank_upper_ci = round(mos_a_sorted(1)+ ci_a_sorted(1),2);
    for i= 2:length(mos_a_sorted)
        % check for overlapping 95% CI
        % no more than 2 decimal digits
        %it should be also in a same area of first item in this rank
        if (not(round(mos_a_sorted(i-1)+ci_a_sorted(i-1),2) >= round(mos_a_sorted(i),2) || ...
                round(mos_a_sorted(i)-ci_a_sorted(i),2) <= round(mos_a_sorted(i-1),2)) || ...
                last_rank_upper_ci < round(mos_a_sorted(i),2))
            % no overlap
            last_rank = last_rank+1;
            last_rank_upper_ci = round(mos_a_sorted(i)+ ci_a_sorted(i),2);
            
        end
        rank_a(i) = last_rank;
    end
    
    
    last_rank = 1;
    last_rank_upper_ci = round(mos_b_sorted(1)+ ci_b_sorted(1),2);
    for i= 2:length(mos_b_sorted)
        % check for overlapping 95% CI
        % no more than 2 decimal digits
        %it should be also in a same area of first item in this rank
        if (not(round(mos_b_sorted(i-1)+ci_b_sorted(i-1),2) >= round(mos_b_sorted(i),2) || ...
                round(mos_b_sorted(i)-ci_b_sorted(i),2) <= round(mos_b_sorted(i-1),2)) || ...
                last_rank_upper_ci < round(mos_b_sorted(i),2))
            % no overlap
            last_rank = last_rank+1;
            last_rank_upper_ci = round(mos_b_sorted(i)+ ci_b_sorted(i),2);
            
        end
        rank_b(i) = last_rank;
    end
    
    % set the rank in order of original input
    unsorted  = 1:length(mos_a_order);
    new_ind_a(mos_a_order) =  unsorted;
    new_ind_b(mos_b_order) =  unsorted;
    rank_a_orginal_order= rank_a(new_ind_a);
    rank_b_orginal_order= rank_b(new_ind_b);
    
    % now calculate the spearman's corr
    [rho_star, pval]= corr(rank_a_orginal_order,rank_b_orginal_order ,...
        'type','Spearman');
end