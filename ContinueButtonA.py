import logging
from JoycontrolPlugin import JoycontrolPlugin

logger = logging.getLogger(__name__)

class ContinueButtonA(JoycontrolPlugin):
    async def run(self):
        logger.info('Continue Button A Plugin')
        while (True):
            logger.info('Push Button A')
            await self.button_push('a')
            await self.wait(0.1)
            logger.info('Release Button A')
            await self.button_release('a')
            await self.wait(0.1)
