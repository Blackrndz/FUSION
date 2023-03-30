/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Lot Grades - Lot Grades.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT LotGradeVO.GRADE_CODE          RES_GRADE,
  LotGradeVO.DESCRIPTION              RES_DESCRIPTION,
  decode(LotGradeVO.DISABLE_FLAG,'Y','No','Yes')             RES_ACTIVE
,LotGradeVO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LotGradeVO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LotGradeVO.CREATED_BY RSC_CREATED_BY
,LotGradeVO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_GRADES_VL LotGradeVO
ORDER BY LotGradeVO.GRADE_CODE