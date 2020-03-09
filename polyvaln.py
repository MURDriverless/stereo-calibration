import csv

class polyvaln:
    """!
    Class wrapper for evaluating multivariate polynomial functions

    @see [`polyvaln.m`](https://au.mathworks.com/matlabcentral/fileexchange/34765-polyfitn)
    """
    
    def __init__(self, model_csv, coeff_csv):
        """!
        @brief Class constructor

        Constructor takes in csv produced by `mat2CSV.m` of `polyfitn.m` models
        @param[in] self Object pointer
        @param[in] model_csv Path to model exponents in csv format
        @param[in] coeff_csv Path to model coefficient in csv format
        """

        with open(model_csv, 'r') as csvfile:
            csvReader = csv.reader(csvfile)

            ## Array of model exponents
            self._model_terms = [list(map(float, row)) for row in csvReader]

        with open(coeff_csv, 'r') as csvfile:
            csvReader = csv.reader(csvfile)

            ## Array of model coefficients
            self._coeff_terms = [list(map(float, row)) for row in csvReader][0]

        ## Number of indepedant variables in model
        self._num_var = len(self._model_terms[0])

    def eval(self, *args) -> float:
        """!
        @brief Evaluate polynomial model at @p args

        @param[in] self Object pointer
        @param[in] *args Variable length arguements, arguements must match model size

        @return Model evaluated at @p args

        @throws Exception When an incorrect number of arguments is passed to function. 
        """

        if len(args) != self._num_var:
            raise Exception('Incorrect number of arguments for model. n = {}'.format(self._num_var))

        output = 0
        for powers, coeff in zip(self._model_terms, self._coeff_terms):
            partial = 1
            for arg, power in zip(args, powers):
                partial *= arg**power

            output += coeff*partial
        return output

    def __call__(self, *args) -> float:
        """!
        Overload object calling for syntax sugar.

        @copydoc polyvaln.polyvaln::eval

        @see @link polyvaln.polyvaln::eval @endlink
        """
        return self.eval(*args)