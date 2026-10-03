#include "Stage.h"
#include "MovingEnemy.h"
#include "Direction.h"
#include "Sprite.h"

constexpr byte MaxMemberCount = MaxEnemyCount;

struct Team {
    byte memberCount;
    ptr<Formation> pFormation;
    ptr<Course> pCourse;
    byte nextMember;
    ptr<MovingEnemy>[MaxMemberCount] members;
    byte sallyCount;
    byte directionIndex;
    byte courceElementIndex;
    ptr<CourseElement> pCourseElement;
    byte[MaxMemberCount * 2] directions;
};

extern Team[] Teams;

extern ptr<Formation> pFormation;
extern byte FormationCount;

extern void InitTeams();
extern void StartTeam();
extern void MoveTeams();
extern void RemoveMember(ptr<MovingEnemy> pEnemy);
