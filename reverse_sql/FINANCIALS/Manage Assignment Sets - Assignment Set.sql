/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-07-20  $:
 * $HeadURL:  $:
 * $Id: Manage Assignment Sets - Assignment Set $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_ASSIGNMENT_SETS

SELECT MscAssignmentSets.ASSIGNMENT_SET_NAME RES_NAME
,MscAssignmentSets.DESCRIPTION RES_DESCRIPTION
,(CASE
	WHEN MscAssignmentSets.CATEGORY_SET_ID IS NULL THEN
		(SELECT CATEGORY_SET_NAME
		FROM MSC_CATEGORY_SETS
		WHERE DEFAULT_FLAG = 1)
	ELSE
		(SELECT CATEGORY_SET_NAME
		FROM MSC_CATEGORY_SETS
		WHERE CATEGORY_SET_ID = MscAssignmentSets.CATEGORY_SET_ID)
	END) RES_CATALOG
,MscAssignmentSets.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MscAssignmentSets.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MscAssignmentSets.CREATED_BY RSC_CREATED_BY
,MscAssignmentSets.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_ASSIGNMENT_SETS MscAssignmentSets