#include "operators.hh"

namespace ctl {
  // compute states matching : TRUE
  its::State computeTrue (const CTLChecker & checker) {
    return checker.getReachable();
  }

  // compute states matching : FALSE
  its::State computeFalse (const CTLChecker & checker) {
    return its::State::null;
  } ;

  // compute initial states 
  its::State computeInitial (const CTLChecker & checker) { return checker.getInitialState(); };
  
  // compute states matching a predicate p
  its::State computeAtomicPredicate (Label pred, const CTLChecker & checker) { return checker.getAtomicPredicate(pred) (checker.getReachable()) ; }


  //////////// Boolean cases

  // p AND q
  its::State computeAnd (Ctlp_Formula_t * p, Ctlp_Formula_t * q, const CTLChecker & checker) { return checker.getStateVerifying(p) * checker.getStateVerifying(q); } 

  // p OR q
  its::State computeOr (Ctlp_Formula_t * p, Ctlp_Formula_t * q, const CTLChecker & checker) { return checker.getStateVerifying(p) + checker.getStateVerifying(q); } 

  // NOT(p)
  its::State computeNot (Ctlp_Formula_t * p, const CTLChecker & checker) { return checker.getReachable() - checker.getStateVerifying(p); } 

  // p => q  (p implies q)
  its::State computeImplies (Ctlp_Formula_t * p, Ctlp_Formula_t * q, const CTLChecker & checker) { return computeNot(p,checker) + checker.getStateVerifying(q); }

  ////////////// Temporal operators
  
  // compute states matching : EX p
  its::State computeEX (Ctlp_Formula_t * p,  const CTLChecker & checker) { return checker.getPredRel()(checker.getStateVerifying(p)); }

  // compute states matching : E ( p U q )
  its::State computeEU (Ctlp_Formula_t * p,  Ctlp_Formula_t * q, const CTLChecker & checker) {
    its::State S = checker.getStateVerifying(q);
    its::State N = its::State::null;
    its::State P = checker.getStateVerifying(p);
    while (S != N) {
      N = S;
      S = S + (P* checker.getPredRel() (S));
    }
    return S;
  }

  // compute states matching : EG p
  its::State computeEG (Ctlp_Formula_t * p, const CTLChecker & checker) {
    its::State S = checker.getStateVerifying(p);
    its::State N = its::State::null;
    while (S != N) {
      N = S;
      S = S *  checker.getPredRel() (S) ;
    }
    return S;
  }


}
