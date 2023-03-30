/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (
	CASE
		WHEN EXISTS
			(SELECT NULL
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			--WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'INV'
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE IN ('ENTERPRISE','HCM_DIVISION','DEPARTMENT','FUN_BUSINESS_UNIT','INV')
			AND CostOrganizationEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND EXISTS
				(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
				WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'CST'
				AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
				AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
				)
			)
		THEN 'Select an existing organization'
		ELSE 'Create new'
	END) RES_CREATE_ORGANIZATION
--DECODE(CLASS_CODE.CLASSIFICATION_NAME,NULL,'Create new','Select an existing organization') RES_CREATE_ORGANIZATION
,TO_CHAR(CostOrganizationEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,CostOrganizationEO.NAME RES_NAME
--,CLASS_CODE.CLASSIFICATION_NAME RES_CLASSIFICATION
,(
	CASE
		WHEN EXISTS
			(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
				WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE IN ('ENTERPRISE','HCM_DIVISION','DEPARTMENT','INV')
				AND CostOrganizationEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
				AND EXISTS
					(SELECT NULL
					FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
					WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'CST'
					AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
					AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
				)		
			)
		THEN
			(SELECT CLASSIFICATION_NAME
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			,HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO2
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'CST'
			AND OrgUnitClassificationDEO2.CLASSIFICATION_CODE    = OrgClassificationEO2.CLASSIFICATION_CODE
			AND CostOrganizationEO.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND rownum                                          <= 1
			)
		ELSE NULL
	END) RES_CLASSIFICATION
,DECODE(CostOrganizationEO.STATUS,'A','Active','Inactive') RES_STATUS
,CostOrgInfoEO.ORG_INFORMATION2 RES_COST_ORGANIZATION_CODE
,XleEntityProfiles.NAME RES_LEGAL_ENTITY_NAME
,CostOrganizationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CostOrganizationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CostOrganizationEO.CREATED_BY RSC_CREATED_BY
,CostOrganizationEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,CostOrganizationEO.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ORGANIZATION_V CostOrganizationEO
,HR_ORG_DETAILS_BY_CLASS_V CostOrgInfoEO
,XLE_ENTITY_PROFILES XleEntityProfiles
/*,(SELECT *
	FROM
		(SELECT Org.ORGANIZATION_ID
		,OrgCode.CLASSIFICATION_NAME
		,ROW_NUMBER() OVER(PARTITION BY Org.ORGANIZATION_ID ORDER BY Org.ORGANIZATION_ID) LINE
		FROM HR_ORGANIZATION_V Org
		,HR_ORG_CLASSIFICATIONS_VL OrgCode
		WHERE Org.CLASSIFICATION_CODE = OrgCode.CLASSIFICATION_CODE
		AND SYSDATE BETWEEN Org.EFFECTIVE_START_DATE AND Org.EFFECTIVE_END_DATE
		AND Org.CLASSIFICATION_CODE NOT IN('CST','FUN_BUSINESS_UNIT')
		AND Org.ORGANIZATION_ID         IN
			(SELECT ORGANIZATION_ID
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F
			WHERE CLASSIFICATION_CODE = 'CST'
			)
		)
	WHERE LINE = 1) CLASS_CODE*/
WHERE(CostOrganizationEO.ORGANIZATION_ID  = CostOrgInfoEO.ORGANIZATION_ID)
AND(CostOrgInfoEO.ORG_INFORMATION_NUMBER1 = XleEntityProfiles.LEGAL_ENTITY_ID)
--AND(CostOrganizationEO.ORGANIZATION_ID  = CLASS_CODE.ORGANIZATION_ID(+))
AND CostOrganizationEO.CLASSIFICATION_CODE = 'CST'
AND(SYSDATE BETWEEN CostOrganizationEO.EFFECTIVE_START_DATE AND CostOrganizationEO.EFFECTIVE_END_DATE)
AND(SYSDATE BETWEEN CostOrgInfoEO.EFFECTIVE_START_DATE AND CostOrgInfoEO.EFFECTIVE_END_DATE)
ORDER BY CostOrganizationEO.NAME