import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

public class CSP<V, D> {

    private List<V> variables;
    private Map<V, List<D>> domains;
    private Map<V, List<Constraint<V, D>>> constraints = new HashMap<>();

    public CSP(List<V> variables, Map<V, List<D>> domains) {
        this.variables = variables;
        this.domains = domains;
        for (V var : variables) {
            constraints.put(var, new ArrayList<>());
            if (!domains.containsKey(var)) {
                throw new IllegalArgumentException("each variable should have a domain");
            }
        }
    }

    public void addConstraint(Constraint<V, D> constraint) {
        for (V var : constraint.variables) {
            if (!variables.contains(var)) {
                throw new IllegalArgumentException("contraint variable not in CSP");
            }
            constraints.get(var).add(constraint);
        }
    }

    public boolean consistent(V variable, Map<V, D> assignment) {
        for (var constraint : constraints.get(variable)) {
            if (!constraint.satisfied(assignment)) {
                return false;
            }
        }
        return true;
    }
}
