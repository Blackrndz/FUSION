/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT 
(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = AbcAssignmentGroup.ORGANIZATION_ID
	) RES_ORGANIZATION
,AbcAssignmentGroup.ASSIGNMENT_GROUP_NAME RES_ASSIGNMENT_GROUP_NAME
,MtlAbcAssgnGroupClasses.SEQUENCE_NUMBER RES_SEQUENCE
,InvAbcClasses.ABC_CLASS_NAME RES_NAME
,InvAbcClasses.DESCRIPTION RES_DESCRIPTION
,MtlAbcAssgnGroupClasses.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlAbcAssgnGroupClasses.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlAbcAssgnGroupClasses.CREATED_BY RSC_CREATED_BY
,MtlAbcAssgnGroupClasses.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,AbcAssignmentGroup.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_ABC_ASSIGNMENT_GROUPS AbcAssignmentGroup
,INV_ABC_ASSGN_GROUP_CLASSES MtlAbcAssgnGroupClasses
,INV_ABC_CLASSES InvAbcClasses
WHERE AbcAssignmentGroup.ASSIGNMENT_GROUP_ID = MtlAbcAssgnGroupClasses.ASSIGNMENT_GROUP_ID
AND MtlAbcAssgnGroupClasses.ABC_CLASS_ID   = InvAbcClasses.ABC_CLASS_ID
ORDER BY RES_ORGANIZATION
,AbcAssignmentGroup.ASSIGNMENT_GROUP_NAME
,MtlAbcAssgnGroupClasses.SEQUENCE_NUMBER