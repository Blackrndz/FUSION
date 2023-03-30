/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_PROPERTIES

SELECT (SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_ASSIGN_ATTR_LOOKUP'
    AND LOOKUP_CODE = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'MANAGE_LRNR_ASSIGN_AS')
	) RES_ASSIGN_AS
,lookupsEo.MEANING RES_SUMMARY_METRICS
,'' RES_SUMMARY_STATUS
,setupsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,setupsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,setupsE0.CREATED_BY  RSC_CREATED_BY
,setupsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WLF_PROPERTIES setupsE0
,FND_LOOKUP_VALUES lookupsEo
WHERE lookupsEo.LANGUAGE = USERENV('LANG')
AND lookupsEo.LOOKUP_TYPE = 'ORA_WLF_ASSIGNMENT_METRICS'
AND lookupsEo.LOOKUP_CODE = setupsE0.NAME
ORDER BY setupsE0.VALUE