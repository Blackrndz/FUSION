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
			--WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE IN ('ENTERPRISE','HCM_DIVISION','DEPARTMENT','HCM_DISABILITY_ORGANIZATION')
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'ORA_PER_UNION'
			AND workerUnionsE0.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND EXISTS
				(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
				WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'ORA_PER_UNION'
				AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
				AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
				)
			)
		THEN 'Select an existing organization'
		ELSE 'Create new'
	END)  RES_CREATE_BY
,TO_CHAR(workerUnionsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE = workerUnionsE0.LEGISLATION_CODE 
	) RES_COUNTRY
,workerUnionsE0.NAME RES_NAME
,(CASE
		WHEN EXISTS
			(SELECT NULL
				FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
				WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'ORA_PER_UNION'
				AND workerUnionsE0.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
				AND EXISTS
					(SELECT NULL
					FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO3
					WHERE OrgUnitClassificationDEO3.CLASSIFICATION_CODE = 'ORA_PER_UNION'
					AND OrgUnitClassificationDEO2.ORGANIZATION_ID       = OrgUnitClassificationDEO3.ORGANIZATION_ID
					AND OrgUnitClassificationDEO3.creation_date         > orgUnitClassificationDEO2.creation_date
				)		
			)
		THEN
			(SELECT CLASSIFICATION_NAME
			FROM HR_ORG_UNIT_CLASSIFICATIONS_F OrgUnitClassificationDEO2
			,HR_ORG_CLASSIFICATIONS_VL OrgClassificationEO2
			WHERE OrgUnitClassificationDEO2.CLASSIFICATION_CODE != 'ORA_PER_UNION'
			AND OrgUnitClassificationDEO2.CLASSIFICATION_CODE    = OrgClassificationEO2.CLASSIFICATION_CODE
			AND workerUnionsE0.ORGANIZATION_ID              = OrgUnitClassificationDEO2.ORGANIZATION_ID
			AND rownum                                          <= 1
			)
		ELSE NULL
	END) RES_CLASSIFICATION
,workerUnionsE0.INTERNAL_ADDRESS_LINE RES_INTERNAL_ADDRESS_LINE
,DECODE(workerUnionsE0.STATUS,'A','Active','I','Inactive') RES_STATUS
,(SELECT ACTION_REASON
    FROM PER_ACTION_OCCURRENCES actOccE0
    ,PER_ACTION_REASONS_TL ActReasonsE0
    WHERE ActReasonsE0.LANGUAGE = USERENV('LANG')
    AND actOccE0.ACTION_REASON_ID = ActReasonsE0.ACTION_REASON_ID
    AND actOccE0.ACTION_OCCURRENCE_ID = workerUnionsE0.ACTION_OCCURRENCE_ID
    ) RES_ACTION_REASON
,(SELECT LOCATION_NAME 
	FROM PER_LOCATION_DETAILS_F_VL
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND LOCATION_ID = workerUnionsE0.LOCATION_ID 
	) RES_LOCATION_ADDRESS
,InfoEO.ORG_INFORMATION1 RES_CODE
,InfoEO.ORG_INFORMATION2 RES_DESCRIPTION
,workerUnionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,workerUnionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,workerUnionsE0.CREATED_BY RSC_CREATED_BY
,workerUnionsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ORGANIZATION_V workerUnionsE0
,(SELECT ORGANIZATION_ID
	,ORG_INFORMATION1
	,ORG_INFORMATION2
	FROM HR_ORGANIZATION_INFORMATION_F 
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND ORG_INFORMATION_CONTEXT = 'ORA_PER_UNION_ADDITIONAL_INFORMATION'
	) InfoEO
WHERE workerUnionsE0.ORGANIZATION_ID = InfoEO.ORGANIZATION_ID(+)
AND workerUnionsE0.CLASSIFICATION_CODE = 'ORA_PER_UNION'
--AND SYSDATE BETWEEN workerUnionsE0.EFFECTIVE_START_DATE AND workerUnionsE0.EFFECTIVE_END_DATE
ORDER BY RES_COUNTRY,workerUnionsE0.NAME,workerUnionsE0.EFFECTIVE_START_DATE