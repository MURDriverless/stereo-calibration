import csv

class polyvaln:
    _model_terms = []
    _coeff_terms = []
    _num_var = 0
    
    def __init__(self, model_csv, coeff_csv):
        with open(model_csv, 'r') as csvfile:
            csvReader = csv.reader(csvfile)
            self._model_terms = [list(map(float, row)) for row in csvReader]

        with open(coeff_csv, 'r') as csvfile:
            csvReader = csv.reader(csvfile)
            self._coeff_terms = [list(map(float, row)) for row in csvReader][0]

        self._num_var = len(self._model_terms[0])

    def eval(self, *args):
        if len(args) != self._num_var:
            raise Exception('Incorrect number of arguments for model. n = {}'.format(self._num_var))
            return

        output = 0
        for powers, coeff in zip(self._model_terms, self._coeff_terms):
            partial = 1
            for arg, power in zip(args, powers):
                partial *= arg**power

            output += coeff*partial
        return output

    def __call__(self, *args):
        return self.eval(*args)
            

a = polyvaln('csvFit/modelTerms.csv', 'csvFit/x_coeff.csv')
test = [1,1,1,1]
print(a.eval(*test))
