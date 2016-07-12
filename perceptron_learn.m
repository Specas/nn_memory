function [weights, gerror_history] = perceptron_learn(x, d, weights, alpha, iterations)

	[m, n] = size(x);
	gerror_history = zeros(iterations, 1);

	for i=1:iterations
		%Global error
		gerror = 0;

		for j=1:m
			z = x(j, :)*weights;
			%Output. Sigmoid activation used.
			y = sigmoid(z);
			% disp(y);
			%Error signal
			err = d(j) - y;

			%Updating weights by perceptron learning rule
			weights += (alpha*err*(x(j, :)'));

			gerror = gerror + err*err;

		end

		gerror_history(i) = gerror;

		% disp(gerror);

	end
	% fprintf('-----\n');
end


