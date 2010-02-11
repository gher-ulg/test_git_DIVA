MODULE moduleValuesArray1DManagement

! ============================================================
! ============================================================
! ============================================================
! ===                                                      ===
! ===                                                      ===
! ===                  Module specifications               ===
! ===                                                      ===
! ===                                                      ===
! ============================================================
! ============================================================
! ============================================================


! Include file
! ============
  USE moduleWorkingArray, ONLY : workingArray
  USE moduleMemoryArrayManagement, ONLY : memoryGetFirstIndexX, memoryGetLastIndexX, &
                                          memorySetFirstIndex, memorySetSize, memoryDefineLastIndex, &
                                          memoryGetSizeX, memoryGetAllocatedSizeX
  USE moduleMemoryArrayNDManagement, ONLY : memoryAllocateArray
  USE moduleValuesArrayManagement, ONLY : memoryGetPointerOnValue, memoryGetValues

! Declaration
! ===========

  INCLUDE 'constantParameter.h'

! Procedures status
! =================

!  General part
!  ------------
   PUBLIC :: memoryArraySetToZero, memoryArraySetToValue, memoryArrayInsertValue, memoryArrayAddValue, memoryArrayFastInsertValue, &
             memoryArrayFastAddValue, memoryPutIn


! ============================================================
! ============================================================
! ============================================================
! ===                                                      ===
! ===                                                      ===
! ===                  Module procedures                   ===
! ===                                                      ===
! ===                                                      ===
! ============================================================
! ============================================================
! ============================================================
 CONTAINS


! =============================================================
! ===            Internal procedure ("PUBLIC")  : Others    ===
! =============================================================
! Procedure 1 : set 0 to each entry
! ---------------------------------
  SUBROUTINE memoryArraySetToZero()

!     Declaration
!     - - - - - -
      VARType, PARAMETER :: val = 0

!     Body
!     - - -
      CALL memoryArraySetToValue(val)

  END SUBROUTINE

! Procedure 2 : set "value" to each entry
! ---------------------------------------
  SUBROUTINE memoryArraySetToValue(val)

!     Declaration
!     - - - - - -
      INTEGER :: istartX, iendX
      VARType, DIMENSION(:), POINTER :: ptr
      VARType, INTENT(IN) :: val

!     Body
!     - - -
      istartX = memoryGetFirstIndexX()
      iendX = memoryGetLastIndexX()

      ptr =>  memoryGetValues()

      ptr(istartX:iendX) = val

  END SUBROUTINE

! Procedure 3 : insert value in array (scracth the previous one)
! ---------------------------------------------------------------
  SUBROUTINE memoryArrayInsertValue(positionX,val)

!     Declaration
!     - - - - - -
      INTEGER, INTENT(IN) :: positionX
      INTEGER :: istartX, iendX
      VARType, INTENT(IN) :: val

!     Body
!     - - -
      istartX = memoryGetFirstIndexX()

      IF ( ( positionX < istartX ) ) THEN
         CALL memorySetFirstIndex(positionX)
         CALL memorySetSize(istartX-positionX+memoryGetSizeX())
         CALL memoryDefineLastIndex()
         CALL memoryAllocateArray()
         GOTO 30
      ENDIF

      iendX = memoryGetLastIndexX()

      IF ( ( positionX > iendX ) ) THEN
         CALL memorySetSize(positionX-iendX + memoryGetSizeX())
         CALL memoryDefineLastIndex()
         CALL memoryAllocateArray()
      ENDIF

30    CONTINUE

         CALL memoryArrayFastInsertValue(positionX,val)

  END SUBROUTINE

! Procedure 4 : add value in array (value = old value + new value)
! -----------------------------------------------------------------
  SUBROUTINE memoryArrayAddValue(positionX,val)

!     Declaration
!     - - - - - -
      INTEGER, INTENT(IN) :: positionX
      INTEGER :: istartX, iendX
      VARType, INTENT(IN) :: val

!     Body
!     - - -
      istartX = memoryGetFirstIndexX()
      IF ( positionX < istartX ) RETURN

      iendX = memoryGetLastIndexX()
      IF ( positionX > iendX ) RETURN

      CALL memoryArrayFastAddValue(positionX,val)

  END SUBROUTINE

! Procedure 5 : fast insert value (no check)
! ------------------------------------------
  SUBROUTINE memoryArrayFastInsertValue(positionX,val)

!     Declaration
!     - - - - - -
      INTEGER, INTENT(IN) :: positionX
      VARType, INTENT(IN) :: val

!     Body
!     - - -

      workingArray%values(positionX) = val

  END SUBROUTINE

! Procedure 6 : fast add value (no check)
! ------------------------------------------
  SUBROUTINE memoryArrayFastAddValue(positionX,val)

!     Declaration
!     - - - - - -
      INTEGER, INTENT(IN) :: positionX
      VARType, INTENT(IN) :: val
      VARType, POINTER :: ptr

!     Body
!     - - -
      ptr => memoryGetPointerOnValue(positionX)
      ptr = ptr + val

  END SUBROUTINE

! Procedure 7 : put value in vector by displacing the others of the vector
! ------------------------------------------------------------------------
   SUBROUTINE memoryPutIn(iposition,value)

!    Declaration
!    - - - - - -
     INTEGER, INTENT(IN) :: iposition
     INTEGER :: iEndValueX, istartValueX
     VARType, PARAMETER :: intermediateVal = 0
     VARType, DIMENSION(:), POINTER :: ptr
     VARType :: value

!    Body
!    - - -
     istartValueX = memoryGetFirstIndexX()
     iEndValueX = memoryGetLastIndexX()

     IF ( iposition < istartValueX ) THEN
        CALL memoryArrayInsertValue(iposition,value)
        GOTO 30
     END IF
     IF ( iposition > iEndValueX ) THEN
        CALL memoryArrayInsertValue(iposition,value)
        GOTO 30
     END IF

     CALL memoryArrayInsertValue(iEndValueX+ione,intermediateVal)

     ptr =>  memoryGetValues()

     ptr(iposition+ione:iEndValueX+ione) = ptr(iposition:iEndValueX)
     ptr(iposition) = value

30   CONTINUE

   END SUBROUTINE

END MODULE moduleValuesArray1DManagement