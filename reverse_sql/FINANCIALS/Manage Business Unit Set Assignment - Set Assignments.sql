/* ****************************************************************************
 * $Revision: 64366 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-10-10 11:10:32 +0700 (Tue, 10 Oct 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Business%20Unit%20Set%20Assignment%20-%20Manage%20Set%20Assignments.sql $:
 * $Id: Manage Business Unit Set Assignment - Manage Set Assignments.sql 64366 2017-10-10 04:10:32Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT businessinfo.Name RES_BUSINESS_UNIT_NAME
,SetIdReferenceGroupPEO.VISIBLE_GROUP_NAME RES_REFERENCE_DATA_OBJECT
,SetIdSetsEO.SET_CODE RES_REFERENCE_DATA_SET_CODE
,SetIdSetsEO.SET_NAME RES_REFERENCE_DATA_SET_NAME
,SetIdAssignmentsEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SetIdAssignmentsEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SetIdAssignmentsEO.CREATED_BY  RSC_CREATED_BY
,SetIdAssignmentsEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,businessinfo.ORGANIZATION_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_SETID_ASSIGNMENTS SetIdAssignmentsEO
,FND_SETID_REFERENCE_GROUPS_VL SetIdReferenceGroupPEO
,FND_SETID_SETS_VL SetIdSetsEO
,(SELECT BusinessUnitEO.ORGANIZATION_ID,
    BusinessUnitEO.NAME
	FROM HR_ORGANIZATION_V BusinessUnitEO
	WHERE BusinessUnitEO.CLASSIFICATION_CODE           = 'FUN_BUSINESS_UNIT'
	AND(sysdate BETWEEN BusinessUnitEO.EFFECTIVE_START_DATE AND BusinessUnitEO.EFFECTIVE_END_DATE)
	) businessinfo
WHERE (SetIdAssignmentsEO.REFERENCE_GROUP_NAME(+) = SetIdReferenceGroupPEO.REFERENCE_GROUP_NAME)
AND (SetIdAssignmentsEO.SET_ID                    = SetIdSetsEO.SET_ID(+))
AND SetIdReferenceGroupPEO.DETERMINANT_TYPE       = 'BU'
AND SetIdAssignmentsEO.DETERMINANT_TYPE(+)        = 'BU'
AND SetIdAssignmentsEO.DETERMINANT_VALUE          = businessinfo.ORGANIZATION_ID(+)
ORDER BY businessinfo.Name
,RES_REFERENCE_DATA_OBJECT