constexpr byte Solver_Status_Live = 1;
constexpr byte Solver_Status_Die = 0;

extern byte SolverX;
extern byte SolverY;
extern byte SolverStatus;

extern void InitSolver(byte x, byte y);
extern void MoveSolver();
extern void EndSolver();
