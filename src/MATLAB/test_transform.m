%% test cases
disp('Test 1- Figure 3 ');
% case a: 
disp('test condition a');
mos = [ 10,5];
ci = [2,2];
expected_rank = [2,1];
t = transform_mos(mos,ci); 
assert(isequal(t,expected_rank))

% case b: 
disp('test condition b');
mos = [10, 6];
ci = [3, 2];
expected_rank = [2,1];
t = transform_mos(mos,ci); 
assert(isequal(t,expected_rank));

% case c: 
disp('test condition c');
mos = [10, 7];
ci = [4, 2];
expected_rank = [1,1];
t = transform_mos(mos,ci); 
assert(isequal(t,expected_rank));

% case d: 
disp('test condition d');
mos = [10, 8, 5.5];
ci = [4, 3, 1];
expected_rank = [2,2,1];
t = transform_mos(mos,ci); 
assert(isequal(t,expected_rank));

% case e: 
disp('test condition e');
mos = [10, 6, 5.5];
ci = [4, 2, 0.2];
expected_rank = [2,1,1];
t = transform_mos(mos,ci); 
assert(isequal(t,expected_rank));

% case f: 
disp('test condition f');
mos = [10, 7, 9];
ci = [4, 2, 0.2];
expected_rank = [1,1,1];
t = transform_mos(mos,ci); 
assert(isequal(t,expected_rank));

%%
disp('Test 2- an example set of MOS and 95% CIS.');
mos = [4.49272507194938;4.26577212950124;4.10033767612383;3.93832658710171;3.93935656976414;3.91288674666551;3.91261926134431;3.84816451136751;3.71592312027156;3.74955202733778];
ci =[0.0879000000000000;0.0984000000000000;0.105800000000000;0.0950000000000000;0.101600000000000;0.102700000000000;0.109500000000000;0.116500000000000;0.0973000000000000;0.123600000000000];

draw_many(mos,ci);

function draw_many(mos,ci)
    figure;
    transformed_ranks = transform_mos(mos,ci); 
    for i =1:length(mos)
        e = errorbar(i,mos(i),ci(i),'o');
        text(i-0.3,3.2,['r=',num2str(transformed_ranks(i))],'FontWeight','bold');
        e.Color = '#0072BD';
        e.LineWidth = 1.5;
        e.MarkerFaceColor = 'auto';
        hold on;
    end
    xlim([1-0.5 length(mos)+0.5]);
    ylim([3 5]);
    grid on;
    hold off;
end