tic;
clc;
clear;
close all;

%%in
slCharacterEncoding('UTF-8');
csvfilename = regexprep(mfilename, 'plot', '');
fpath = ['../tab/' csvfilename '.csv'];
col = 22;
format = '%s';
for k = 2:col
	format = [format '%f'];
end

%%process
fid = fopen(fpath);
if fid ~= -1
	datacell = textscan(fid, format,'delimiter', ',');
	name = datacell{1};
	xname = name{1};
	datacell(1) = [];
	datamat = cell2mat(datacell);
	data = sortrows(datamat', 1)';
	for k = 2:size(data, 1)
		figure('NumberTitle', 'off', 'Name', fpath);
		plot(data(1,:), data(k,:), 'rx-');
		yname = name{k};
		yname = regexprep(yname, '\\SI{}{\\(\w*)}', '$1');
		xlabel(xname, 'Interpreter', 'LaTex');
		ylabel(yname, 'Interpreter', 'LaTex');
		title('', 'Interpreter', 'LaTex');
		tablename = regexprep(fpath, '.*/', '');
		tabname = regexprep(tablename, '\.\w*', '');
		figname = [tabname '.png'];
		saveas(gcf, figname);
	end
	fclose(fid);
end

%%out
toc;

