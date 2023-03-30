/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL:  $:
 * $Id: Manage Lot Grades - Lot Grades - DFF.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_GRADES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields. 

SELECT LotGradeVO.GRADE_CODE          				RES_GRADE
,LotGradeVO.ATTRIBUTE_CATEGORY 						RES_CONTEXT_CODE
,LotGradeVO.ATTRIBUTE1
,LotGradeVO.ATTRIBUTE2
,LotGradeVO.ATTRIBUTE3
,LotGradeVO.ATTRIBUTE4
,LotGradeVO.ATTRIBUTE5
,LotGradeVO.ATTRIBUTE6
,LotGradeVO.ATTRIBUTE7
,LotGradeVO.ATTRIBUTE8
,LotGradeVO.ATTRIBUTE9
,LotGradeVO.ATTRIBUTE10
,LotGradeVO.ATTRIBUTE11
,LotGradeVO.ATTRIBUTE12
,LotGradeVO.ATTRIBUTE13
,LotGradeVO.ATTRIBUTE14
,LotGradeVO.ATTRIBUTE15
,LotGradeVO.ATTRIBUTE16
,LotGradeVO.ATTRIBUTE17
,LotGradeVO.ATTRIBUTE18
,LotGradeVO.ATTRIBUTE19
,LotGradeVO.ATTRIBUTE20
,LotGradeVO.ATTRIBUTE21
,LotGradeVO.ATTRIBUTE22
,LotGradeVO.ATTRIBUTE23
,LotGradeVO.ATTRIBUTE24
,LotGradeVO.ATTRIBUTE25
,LotGradeVO.ATTRIBUTE26
,LotGradeVO.ATTRIBUTE27
,LotGradeVO.ATTRIBUTE28
,LotGradeVO.ATTRIBUTE29
,LotGradeVO.ATTRIBUTE30
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
 WHERE(LotGradeVO.ATTRIBUTE_CATEGORY IS NOT NULL
OR LotGradeVO.ATTRIBUTE1            IS NOT NULL
OR LotGradeVO.ATTRIBUTE2            IS NOT NULL
OR LotGradeVO.ATTRIBUTE3            IS NOT NULL
OR LotGradeVO.ATTRIBUTE4            IS NOT NULL
OR LotGradeVO.ATTRIBUTE5            IS NOT NULL
OR LotGradeVO.ATTRIBUTE6            IS NOT NULL
OR LotGradeVO.ATTRIBUTE7            IS NOT NULL
OR LotGradeVO.ATTRIBUTE8            IS NOT NULL
OR LotGradeVO.ATTRIBUTE9            IS NOT NULL
OR LotGradeVO.ATTRIBUTE10           IS NOT NULL
OR LotGradeVO.ATTRIBUTE11           IS NOT NULL
OR LotGradeVO.ATTRIBUTE12           IS NOT NULL
OR LotGradeVO.ATTRIBUTE13           IS NOT NULL
OR LotGradeVO.ATTRIBUTE14           IS NOT NULL
OR LotGradeVO.ATTRIBUTE15           IS NOT NULL
OR LotGradeVO.ATTRIBUTE16            IS NOT NULL
OR LotGradeVO.ATTRIBUTE17            IS NOT NULL
OR LotGradeVO.ATTRIBUTE18            IS NOT NULL
OR LotGradeVO.ATTRIBUTE19            IS NOT NULL
OR LotGradeVO.ATTRIBUTE20            IS NOT NULL
OR LotGradeVO.ATTRIBUTE21            IS NOT NULL
OR LotGradeVO.ATTRIBUTE22            IS NOT NULL
OR LotGradeVO.ATTRIBUTE23            IS NOT NULL
OR LotGradeVO.ATTRIBUTE24            IS NOT NULL
OR LotGradeVO.ATTRIBUTE25           IS NOT NULL
OR LotGradeVO.ATTRIBUTE26           IS NOT NULL
OR LotGradeVO.ATTRIBUTE27           IS NOT NULL
OR LotGradeVO.ATTRIBUTE28           IS NOT NULL
OR LotGradeVO.ATTRIBUTE29           IS NOT NULL
OR LotGradeVO.ATTRIBUTE30           IS NOT NULL
)
ORDER BY LotGradeVO.GRADE_CODE

