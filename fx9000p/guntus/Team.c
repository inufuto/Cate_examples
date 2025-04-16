#include "Team.h"
#include "Coord.h"
#include "Enemy.h"

extern void _deb();

constexpr byte HalfMask = CoordRate * 2 - 1;
constexpr byte InvalidDirection = 0xff;

ptr<Formation> pFormation;
byte FormationCount;

Team[2] Teams;
static byte localClock;

void InitTeams()
{
    ptr<Team> pTeam;
    for (pTeam : Teams) {
        pTeam->memberCount = 0;
    }
    pFormation = pStage->pFormation;
    FormationCount = pStage->formationCount;
    localClock = 0;
}


void StartTeam()
{
    ptr<Team> pTeam;
    if (FormationCount == 0) return;
    if (FreeEnemyCount < pFormation->elementCount) return;
    for (pTeam : Teams) {
        if (pTeam->memberCount == 0) {
            pTeam->pFormation = pFormation;
            {
                ptr<Course> pCourse;
                pCourse = Courses + pFormation->courseIndex;
                pTeam->pCourse = pCourse;
                pTeam->sallyCount = pCourse->sallyCount;
                pTeam->directions[0] = pCourse->direction;
            }
            pTeam->courceElementIndex = 0;
            pTeam->directionIndex = 0;
            {
                byte i, typeByte;
                ptr<byte> pTarget, pType;
                ptr< ptr<MovingEnemy> > ppMember;
                ppMember = pTeam->members;
                pTarget = pFormation->targets;
                pType = pFormation->types;
                typeByte = *pType; ++pType;
                i = 0;
                do {
                    ptr<MovingEnemy> pMember;
                    pMember = StartMovingEnemy(MovingEnemy_StandBy, typeByte & 3);
                    ++EnemyCount;
                    pMember->target = *pTarget;
                    *ppMember = pMember;
                    ++ppMember;
                    ++pTarget;
                    typeByte >>= 2;
                    ++pTeam->memberCount;
                    ++i;
                    if ((i & 3) == 0) {
                        typeByte = *pType; ++pType;
                    }
                } while (i < pFormation->elementCount);
                while (i < MaxMemberCount) {
                    *ppMember = nullptr;
                    ++ppMember;
                    ++i;
                }
                pTeam->nextMember = 0;
            }
            ++pFormation;
            --FormationCount;
            return;
        }
    }
}


void MoveTeams()
{
    ptr<Team> pTeam;
    if ((localClock & CoordMask) == 0) {
        for (pTeam : Teams) {
            if (pTeam->memberCount != 0) {
                if (
                    (localClock & HalfMask) == 0 &&
                    pTeam->nextMember < pTeam->pFormation->elementCount
                ) {
                    ptr<MovingEnemy> pMember;
                    ptr<Course> pCourse;
                    pMember = pTeam->members[pTeam->nextMember];
                    pCourse = pTeam->pCourse;
                    pMember->x = pCourse->x << CoordShift;
                    pMember->y = pCourse->y << CoordShift;
                    pMember->status = MovingEnemy_Sally;
                    ShowMovingEnemy(pMember);
                    ++pTeam->nextMember;
                }
                {
                    ptr< ptr<MovingEnemy> > ppMember;
                    ptr<byte> pDirection;
                    ppMember = pTeam->members;
                    pDirection = pTeam->directions;
                    repeat (MaxMemberCount) {
                        ptr<MovingEnemy> pMember;
                        pMember = *ppMember;
                        if (
                            pMember != nullptr &&
                            pMember->status == MovingEnemy_Sally
                        ) {
                            byte direction;
                            direction = *pDirection;
                            if (direction == InvalidDirection) {
                                pMember->status = MovingEnemy_Align;
                                --pTeam->memberCount;
                                *ppMember = nullptr;
                            }
                            else {
                                SetMovingEnemyDirection(pMember, direction);
                            }
                        }
                        ++ppMember;
                        pDirection += 2;
                    }
                }
                {
                    ptr<byte> pDirection;
                    pDirection = pTeam->directions + MaxMemberCount * 2 - 2;
                    repeat (MaxMemberCount * 2 - 1) {
                        pDirection[1] = pDirection[0];
                        --pDirection;
                    }
                }
                if (pTeam->sallyCount > 0) {
                    --pTeam->sallyCount;
                    pTeam->courceElementIndex = 0;
                    goto nextCourseElement;
                }
                else {
                    ++pTeam->directionIndex;
                    if (pTeam->directionIndex >= DirectionCount) {
                        byte element;
                        ++pTeam->courceElementIndex;
                        nextCourseElement:
                        element = pTeam->pCourse->elements[pTeam->courceElementIndex];
                        if (element == InvalidElement) {
                            pTeam->pCourseElement = nullptr;
                        }
                        else {
                            pTeam->pCourseElement = CourseElements + element;
                            pTeam->directionIndex = 0;
                        }
                    }
                    if (pTeam->pCourseElement == nullptr) {
                        pTeam->directions[0] = InvalidDirection;
                    }
                    else {
                        pTeam->directions[0] = pTeam->pCourseElement->directions[pTeam->directionIndex];
                    }
                }
            }
        }
    }
    ++localClock;
}


void RemoveMember(ptr<MovingEnemy> pEnemy)
{
    ptr<Team> pTeam;
    for (pTeam : Teams) {
        if (pTeam->memberCount != 0) {
            ptr< ptr<MovingEnemy> > ppMember;
            ppMember = pTeam->members;
            repeat (MaxMemberCount) {
                if (*ppMember == pEnemy) {
                    *ppMember = nullptr;
                    --pTeam->memberCount;
                    return;
                }
                ++ppMember;
            }
        }
    }
}
