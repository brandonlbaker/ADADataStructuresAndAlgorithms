generic
type SortElement is (<>);  -- An element J (or K) of the partial ordering
num : integer;
with procedure get(Job:  out SortElement);
with procedure put(Job:  in SortElement);

package GenericTopSort is
   procedure TopologicalSort;
end GenericTopSort;