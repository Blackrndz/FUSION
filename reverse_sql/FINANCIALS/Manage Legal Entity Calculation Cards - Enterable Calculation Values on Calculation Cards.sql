/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Locations%20(United%20States)%20-%20Manage%20Locations.sql $:
 * $Id: Manage Locations (United States) - Manage Locations.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT DISTINCT TaxRptUnitsE0.LE_NAME RES_LEGAL_ENTITY

,TaxRptUnitsE0.LEGAL_ENTITY_IDENTIFIER RES_LEGAL_ENTITY_INDENTIFIER
,(SELECT DISPLAY_NAME
    FROM PAY_DIR_CARD_DEFINITIONS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND DIR_CARD_DEFINITION_ID = leRptCardsE0.DIR_CARD_DEFINITION_ID
    ) RES_CALCULATION_CARD

,calCompDtlsE0.COMPONENT_NAME RES_CALCULATION_COMPONENT
--,cardCompsE0.CONTEXT_VALUE1
,valDefsE0.NAME RES_NAME
,'String' RES_VALUE_TYPE
,(CASE
    WHEN overridesE0.VO_NAME IS NOT NULL THEN
        (CASE
            WHEN overridesE0.VO_NAME = 'oracle.apps.hcm.locUS.payrollSetup.eleEnts.model.blu.view.TimeCardCityOverridesVO' THEN
                (SELECT MEANING
                    FROM FND_LOOKUP_VALUES
                    WHERE LANGUAGE = USERENV('LANG')
                    AND LOOKUP_TYPE = 'ORA_HRX_US_OTL_JURS_OPTION'
                    AND LOOKUP_CODE = valUsgE0.VALUE1)
            WHEN overridesE0.VO_NAME = 'oracle.apps.hcm.locUS.payrollSetup.taxData.model.blu.view.USYesNoLOVVO' THEN
                (SELECT MEANING
                    FROM FND_LOOKUP_VALUES
                    WHERE LANGUAGE = USERENV('LANG')
                    AND VIEW_APPLICATION_ID = 0
                    AND LOOKUP_TYPE = 'YES_NO'
                    AND LOOKUP_CODE = valUsgE0.VALUE1)
        END)
    ELSE
        valUsgE0.VALUE1
    END) RES_VALUE
,TO_CHAR(valUsgE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(valUsgE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,deductionGrpsE0.NAME RES_COMPONENT_GROUP

,valUsgE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,valUsgE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,valUsgE0.CREATED_BY RSC_CREATED_BY
,valUsgE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PAY_DIR_CARDS_F leRptCardsE0
,(SELECT orgsE0.ORGANIZATION_ID
    ,lesE0.NAME LE_NAME
	,lesE0.LEGAL_ENTITY_IDENTIFIER
    FROM HR_ORGANIZATION_V orgsE0
    ,XLE_ENTITY_PROFILES lesE0
    WHERE orgsE0.CLASSIFICATION_CODE = 'HCM_PSU'
    AND SYSDATE BETWEEN orgsE0.EFFECTIVE_START_DATE AND orgsE0.EFFECTIVE_END_DATE
    AND orgsE0.LEGAL_ENTITY_ID = lesE0.LEGAL_ENTITY_ID
    ) TaxRptUnitsE0
,PAY_DIR_CARD_COMPONENTS_F cardCompsE0
,PAY_DEDUCTION_GROUPS_VL deductionGrpsE0
,PAY_DIR_CARD_COMP_DEFS_VL calCompDtlsE0
,PAY_VALUE_DEFINITIONS_VL valDefsE0
,PAY_RANGE_ITEMS_F valUsgE0
,(SELECT DIR_OVERRIDE_USAGE_ID
    ,VO_NAME
    FROM PAY_DIR_OVERRIDE_USAGES_F
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    ) overridesE0
WHERE leRptCardsE0.SOURCE_TYPE = 'PSU'
AND SYSDATE BETWEEN leRptCardsE0.EFFECTIVE_START_DATE AND leRptCardsE0.EFFECTIVE_END_DATE
AND leRptCardsE0.SOURCE_ID = TaxRptUnitsE0.ORGANIZATION_ID

AND leRptCardsE0.DIR_CARD_ID = cardCompsE0.DIR_CARD_ID
AND cardCompsE0.DEDUCTION_GROUP_ID = deductionGrpsE0.DEDUCTION_GROUP_ID

AND cardCompsE0.DIR_CARD_COMP_DEF_ID = calCompDtlsE0.DIR_CARD_COMP_DEF_ID

AND cardCompsE0.DIR_CARD_COMP_ID = valDefsE0.SOURCE_ID
AND valDefsE0.SOURCE_TYPE = 'PDCC'

AND valDefsE0.VALUE_DEFN_ID = valUsgE0.VALUE_DEFN_ID
AND SYSDATE BETWEEN valUsgE0.EFFECTIVE_START_DATE AND valUsgE0.EFFECTIVE_END_DATE

AND valDefsE0.DIR_OVERRIDE_USAGE_ID = overridesE0.DIR_OVERRIDE_USAGE_ID(+)

ORDER BY 1,2,3,4