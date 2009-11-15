MODULE moduleRowCSRMatrix

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
   USE moduleRowCSRMatrixDefinition
   USE moduleWorkingArray, ONLY : setWorkingArray, nullifyArrayPointer

   USE moduleValuesRowCSRMatrixManagement, ONLY : memoryGetValues, memoryGetIndex, memoryGetValue, memoryGetPointerOnValue


! Procedures status
! =================

!  General part
!  ------------
   PUBLIC :: rowCSRMatrixGetValues, rowCSRMatrixGetIndex, rowCSRMatrixGetValue, rowCSRMatrixGetPointerOnValue

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
! ===            Internal procedure ("PUBLIC")  : Getting   ===
! =============================================================

! Procedure 1 : get reference to pointer containing the values
! ------------------------------------------------------------
   FUNCTION rowCSRMatrixGetValues(targetRowCSRMatrix) RESULT(ptr)

!    Declaration
!    - - - - - - -
     TYPE(vectorTypeValue), POINTER :: ptr

!     Pointer filling procedure
!     - - - - - - - - - - - - -
      TYPE(arrayType), INTENT(IN) :: targetRowCSRMatrix
      CALL setWorkingArray(targetRowCSRMatrix)

!     Body
!     - - -
      ptr => memoryGetValues()

!     Nullify pointer
!     - - - - - - - -
      CALL nullifyArrayPointer()

   END FUNCTION

! Procedure 2 : get reference to pointer containing the index
! ------------------------------------------------------------
   FUNCTION rowCSRMatrixGetIndex(targetRowCSRMatrix) RESULT(ptr)

!    Declaration
!    - - - - - - -
     TYPE(vectorTypeIndex), POINTER :: ptr

!     Pointer filling procedure
!     - - - - - - - - - - - - -
      TYPE(arrayType), INTENT(IN) :: targetRowCSRMatrix
      CALL setWorkingArray(targetRowCSRMatrix)

!     Body
!     - - -
      ptr => memoryGetIndex()

!     Nullify pointer
!     - - - - - - - -
      CALL nullifyArrayPointer()

   END FUNCTION

! Procedure 3 : get the value at position i1
! ------------------------------------------
   FUNCTION rowCSRMatrixGetValue(targetRowCSRMatrix,i1) RESULT(val)

!    Declaration
!    - - - - - - -
     INTEGER, INTENT(IN) :: i1
     VARType :: val

!     Pointer filling procedure
!     - - - - - - - - - - - - -
      TYPE(arrayType), INTENT(IN) :: targetRowCSRMatrix
      CALL setWorkingArray(targetRowCSRMatrix)

!     Body
!     - - -
      val = memoryGetValue(i1)

!     Nullify pointer
!     - - - - - - - -
      CALL nullifyArrayPointer()

   END FUNCTION

! Procedure 3 : get the value at position i1
! ------------------------------------------
   FUNCTION rowCSRMatrixGetPointerOnValue(targetRowCSRMatrix,i1) RESULT(val)

!    Declaration
!    - - - - - - -
     INTEGER, INTENT(IN) :: i1
     VARType, POINTER :: val

!     Pointer filling procedure
!     - - - - - - - - - - - - -
      TYPE(arrayType), INTENT(IN) :: targetRowCSRMatrix
      CALL setWorkingArray(targetRowCSRMatrix)

!     Body
!     - - -
      val => memoryGetPointerOnValue(i1)

!     Nullify pointer
!     - - - - - - - -
      CALL nullifyArrayPointer()

   END FUNCTION

END MODULE moduleRowCSRMatrix

