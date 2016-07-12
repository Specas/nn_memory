function [] = plot_error(gerror_history)
	iterations = length(gerror_history);
	hold off;
	figure;
	xplot = linspace(1, iterations, iterations);
	plot(xplot, gerror_history, 'r-');
end