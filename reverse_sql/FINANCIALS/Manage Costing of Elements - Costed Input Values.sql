/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT (SELECT CLASSIFICATION_NAME FROM PAY_ELE_CLASSIFICATIONS_VL 
			WHERE CLASSIFICATION_ID = elementsTYPE0.CLASSIFICATION_ID) RES_PRIMARY_CLASSIFICATION
,elementsTYPE0.ELEMENT_NAME RES_ELEMENT_NAME
,eleLinksE0.NAME RES_INPUT_VALUE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PAY_UNITS'
    AND LOOKUP_CODE =  eleLinksE0.UOM
    ) RES_UOM
,DECODE(eleLinksE0.COSTED_FLAG,'Y','Yes','No') RES_COSTED

,costElesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,costElesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,costElesE0.CREATED_BY RSC_CREATED_BY
,costElesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PAY_COST_INFO_F costElesE0
,PAY_ELEMENT_LINKS_F elementsE0
,(SELECT eleLinksE0.ELEMENT_LINK_ID
    ,inputE0.NAME
	,inputE0.UOM
    ,costLinksE0.COSTED_FLAG
    ,costLinksE0.EFFECTIVE_START_DATE
    ,costLinksE0.EFFECTIVE_END_DATE
    ,costLinksE0.LAST_UPDATE_DATE
    ,costLinksE0.LAST_UPDATED_BY
    ,costLinksE0.CREATION_DATE
    ,costLinksE0.CREATED_BY
    FROM PAY_COST_INFO_F costLinksE0
    ,PAY_LINK_INPUT_VALUES_F eleLinksE0
	,PAY_INPUT_VALUES_VL inputE0
    WHERE costLinksE0.SOURCE_TYPE = 'LIV'
    AND costLinksE0.SOURCE_ID = eleLinksE0.LINK_INPUT_VALUE_ID
	AND eleLinksE0.INPUT_VALUE_ID = inputE0.INPUT_VALUE_ID (+)
    ) eleLinksE0
,PAY_ELEMENT_TYPES_VL elementsTYPE0
WHERE costElesE0.SOURCE_TYPE = 'EL'
AND costElesE0.SOURCE_ID = elementsE0.ELEMENT_LINK_ID
AND costElesE0.SOURCE_ID = eleLinksE0.ELEMENT_LINK_ID
AND elementsE0.ELEMENT_TYPE_ID = elementsTYPE0.ELEMENT_TYPE_ID(+)
AND costElesE0.EFFECTIVE_START_DATE = eleLinksE0.EFFECTIVE_START_DATE
AND costElesE0.EFFECTIVE_END_DATE= eleLinksE0.EFFECTIVE_END_DATE

