function [weights, gerror_history] = perceptron_memory_learn(x, d, weights, alpha, iterations)

	[m, n] = size(x);
	am_global = 0;
	gerror_history = zeros(iterations, 1);
	%Memory unit weight
	wk = 30;

	%Memory parameters
	rho = 1;
	beta1 = 0.1;
	beta2 = 0.1;
	remb = 0;

	for i=1:iterations

		gerror = 0;


		for j=1:m
			z = x(j, :)*weights;
			%Calculate the activation. We use sigmoid activation here
			a = sigmoid(z);
			%We now calculate the memory activation for this particular input and then
			%update the global memory activation if the local am is greater
			am_local = calculate_am(a);
			am_global = max(am_local, am_global);
			% disp(am_global);

			%Check if it is a missclassification
			c = round(a);
			err = 0;
			if c==d(j)
				%Correct classification and the error is the same as the perceptron learning error
				err = d(j) - a;
				%Each time the contents of the memory unit is not accessed, it decays

				%Half volatile code

				rho = rho - beta2;
				if rho<0
					rho = 0;
				end
				% fprintf('%f %d %d\n', rho, j, i);
				remb = calculate_remembrance(rho);
				wk = wk*remb;

				
			else
				%Incorrect classification
				%We now use the memory unit
				% fprintf('Misclassification: %d\n', i);
				a = a + (c-d(j))*((am_global - calculate_am(a))*wk);
				err = d(j) - a;
			end
			
			% disp(wk);

			weights += (alpha*err*(x(j, :)'));

			gerror = gerror + err*err;
		
			

		end

		gerror_history(i) = gerror;

		% disp(gerror);
	
	end
	% fprintf('-----\n');
	if i==iterations
		disp(am_global);
	end
	
end


